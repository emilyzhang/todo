module Tasks.Messages exposing (..)

import Tasks.Models exposing (TaskId)


type Msg
    = CreateTask String
    | AddTask
    | DeleteTask TaskId
    | NoOp
