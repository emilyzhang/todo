module Main exposing (..)

import Html exposing (..)
import View exposing (view)
import Models exposing (Msg(..), Model, Task, TaskId)


-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- INIT


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { tasks =
        [ Task 0 False "apply to internships" False
        , Task 1 True "buy milk" False
        , Task 2 False "finish this todo list" False
        ]
    , newtask = ""
    , currentID = 3
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        CreateTask writetask ->
            ( { model | newtask = writetask }, Cmd.none )

        AddTask ->
            if model.newtask == "" then
                ( model, Cmd.none )
            else
                ( { model
                    | tasks = Task model.currentID False model.newtask False :: model.tasks
                    , currentID = model.currentID + 1
                  }
                , Cmd.none
                )

        DeleteTask taskId ->
            let
                newTasks =
                    List.filter (\t -> t.id /= taskId) model.tasks
            in
                ( { model | tasks = newTasks }, Cmd.none )

        ToggleCheck taskId ->
            let
                newTasks =
                    List.map (toggleDone taskId) model.tasks
            in
                ( { model | tasks = newTasks }, Cmd.none )

        ToggleEdit taskId ->
            let
                newTasks =
                    List.map (toggleEdit taskId) model.tasks
            in
                ( { model | tasks = newTasks }, Cmd.none )

        SaveEdit taskId ->
            let
                newTasks =
                    List.map (editTask taskId model.newtask) model.tasks
            in
                ( { model
                    | tasks = newTasks
                    , newtask = ""
                  }
                , Cmd.none
                )


toggleDone : TaskId -> Task -> Task
toggleDone taskId task =
    if task.id == taskId then
        Task task.id (not task.done) task.action task.editing
    else
        task


toggleEdit : TaskId -> Task -> Task
toggleEdit taskId task =
    if task.id == taskId then
        Task task.id task.done task.action (not task.editing)
    else
        task


editTask : TaskId -> String -> Task -> Task
editTask taskId edit task =
    if task.id == taskId then
        Task task.id task.done edit (not task.editing)
    else
        task
