module Tasks.Update exposing (..)


import Tasks.Messages exposing (Msg(..))
import Tasks.Models exposing (Task)


update : Msg -> List Task -> ( List Task, Cmd Msg )
update message tasks =
    case message of
        NoOp ->
            ( tasks, Cmd.none )
        NewTask addTask ->
            ( Task 0 0 addTask :: tasks , Cmd.none )
