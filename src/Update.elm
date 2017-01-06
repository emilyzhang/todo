module Update exposing (..)


import Messages exposing (Msg(..))
import Models exposing (Model)
import Tasks.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TaskMsg subMsg ->
            let
                ( updatedTasks, cmd ) =
                    Tasks.Update.update subMsg model.tasks
            in
                ( { model | tasks = updatedTasks }, Cmd.map TaskMsg cmd )
