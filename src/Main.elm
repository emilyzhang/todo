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
        [ Task 0 False "apply to internships"
        , Task 1 True "buy milk"
        , Task 2 False "finish this todo list"
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
                    | tasks = Task model.currentID False model.newtask :: model.tasks
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


toggleDone : TaskId -> Task -> Task
toggleDone taskId task =
    if task.id == taskId then
        Task task.id (not task.done) task.action
    else
        task
