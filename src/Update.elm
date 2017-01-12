module Update exposing (..)


import Messages exposing (Msg(..))
import Models exposing (Model)
import Tasks.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TaskMsg subMsg ->
            let
                ( newTask, updatedTasks, cmd ) =
                    Tasks.Update.update subMsg model.newtask model.tasks
            in
                ( { model | tasks = updatedTasks, newtask = newTask }, Cmd.map TaskMsg cmd )
