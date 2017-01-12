module Tasks.Update exposing (..)


import Tasks.Messages exposing (Msg(..))
import Tasks.Models exposing (Task)


update : Msg -> String -> List Task -> ( String, List Task, Cmd Msg )
update message newtask tasks =
    case message of
        NoOp ->
            ( newtask, tasks, Cmd.none )
        CreateTask writetask ->
            -- if String.endsWith "\n" writetask == True then
            --     ( "", Task 0 0 writetask :: tasks, Cmd.none )
            -- else
                ( writetask, tasks, Cmd.none )
        AddTask ->
            if newtask == "" then
                ( "", tasks, Cmd.none )
            else
                ( newtask, Task 0 0 newtask :: tasks, Cmd.none )
        -- NewTask addTask ->
        --     ( Task 0 0 addTask :: tasks, Cmd.none )

-- inputTask : String -> List Task -> ( List Task, Cmd Msg )
-- inputTask newTask tasks =
--     ( Task 0 0 newTask :: tasks, Cmd.none )
