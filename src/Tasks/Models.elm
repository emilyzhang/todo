module Tasks.Models exposing (..)


type alias TaskId =
    Int



-- currentID : Int
-- currentID = 2


type alias Task =
    { id : TaskId
    , checked : Bool
    , action : String
    }
