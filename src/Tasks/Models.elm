module Tasks.Models exposing (..)


type alias TaskId =
  Int


type alias Task =
  { id : TaskId
  , priority: Int
  , action : String
  }
