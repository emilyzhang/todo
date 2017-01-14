module Models exposing (..)

-- MESSAGES


type Msg
    = CreateTask String
    | EditTask String
    | AddTask
    | SaveEdit TaskId
    | DeleteTask TaskId
    | ToggleCheck TaskId
    | ToggleEdit TaskId



-- MODELS


type alias Model =
    { tasks : List Task
    , newtask : String
    , edit : String
    , currentID : Int
    }


type alias TaskId =
    Int


type alias Task =
    { id : TaskId
    , done : Bool
    , action : String
    , editing : Bool
    }
