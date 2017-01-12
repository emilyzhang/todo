module Declarations exposing (..)

-- MESSAGES


type Msg
    = CreateTask String
    | AddTask
    | DeleteTask TaskId



-- MODELS


type alias Model =
    { tasks : List Task
    , newtask : String
    , currentID : Int
    }


type alias TaskId =
    Int


type alias Task =
    { id : TaskId
    , done : Bool
    , action : String
    }
