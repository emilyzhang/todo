port module Main exposing (..)

import Html exposing (..)
import View exposing (view)
import Models exposing (Msg(..), Model, Task, TaskId)


-- MAIN


main : Program (Maybe Model) Model Msg
main =
    programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- INIT


init : Maybe Model -> ( Model, Cmd Msg )
init model =
    case model of
        Just model ->
            ( model, Cmd.none )

        Nothing ->
            ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { tasks =
        [ Task 0 False "hello, this is a simple todo list" False
        , Task 1 True "things are pretty self explanatory" False
        , Task 2 False "so get to work, you overachiever! :)" False
        ]
    , newtask = ""
    , edit = ""
    , currentID = 3
    }



-- PORTS


port setStorage : Model -> Cmd msg



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CreateTask writetask ->
            let
                newModel =
                    { model | newtask = writetask }
            in
                ( newModel, setStorage newModel )

        EditTask edittask ->
            let
                newModel =
                    { model | edit = edittask }
            in
                ( newModel, setStorage newModel )

        AddTask ->
            if model.newtask == "" then
                ( model, Cmd.none )
            else
                let
                    newModel =
                        { model
                            | tasks = model.tasks ++ [ Task model.currentID False model.newtask False ]
                            , currentID = model.currentID + 1
                        }
                in
                    ( newModel, setStorage newModel )

        DeleteTask taskId ->
            let
                newTasks =
                    List.filter (\t -> t.id /= taskId) model.tasks

                newModel =
                    { model | tasks = newTasks }
            in
                ( newModel, setStorage newModel )

        ToggleCheck taskId ->
            let
                newTasks =
                    List.map (toggleDone taskId) model.tasks

                newModel =
                    { model | tasks = newTasks }
            in
                ( newModel, setStorage newModel )

        ToggleEdit taskId ->
            let
                newTasks =
                    List.map (toggleEdit taskId) model.tasks

                newModel =
                    { model | tasks = newTasks }
            in
                ( newModel, setStorage newModel )

        SaveEdit taskId ->
            if model.edit == "" then
                let
                    newTasks =
                        List.map (toggleEdit taskId) model.tasks

                    newModel =
                        { model | tasks = newTasks }
                in
                    ( newModel, setStorage newModel )
            else
                let
                    newTasks =
                        List.map (saveTask taskId model.edit) model.tasks

                    newModel =
                        { model
                            | tasks = newTasks
                            , edit = ""
                        }
                in
                    ( newModel, setStorage newModel )


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


saveTask : TaskId -> String -> Task -> Task
saveTask taskId edit task =
    if task.id == taskId then
        Task task.id task.done edit (not task.editing)
    else
        task
