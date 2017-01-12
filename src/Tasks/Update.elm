module Tasks.Update exposing (..)

import Tasks.Messages exposing (Msg(..))
import Tasks.Models exposing (Task)


update : Msg -> Int -> String -> List Task -> ( Int, String, List Task, Cmd Msg )
update message currentid newtask tasks =
    case message of
        NoOp ->
            ( currentid, newtask, tasks, Cmd.none )

        CreateTask writetask ->
            -- if String.endsWith "\n" writetask == True then
            --     ( "", Task 0 0 writetask :: tasks, Cmd.none )
            -- else
            ( currentid, writetask, tasks, Cmd.none )

        AddTask ->
            if newtask == "" then
                ( currentid + 1, "", tasks, Cmd.none )
            else
                ( currentid, newtask, Task 0 False newtask :: tasks, Cmd.none )

        DeleteTask taskId ->
            let
                newlist =
                    List.filter (\t -> t.id /= taskId) tasks
            in
                ( currentid, newtask, newlist, Cmd.none )
