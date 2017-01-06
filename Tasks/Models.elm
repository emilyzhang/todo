module Tasks.Models exposing (..)

type alias TaskId =
    String


type alias Task =
    { id : TaskId
    , priority: Int
    , action : String
    }
