module Models exposing (..)

import Tasks.Models exposing (Task)


type alias Model =
    { tasks : List Task
    , newtask : String
    , currentID : Int
    }


initialModel : Model
initialModel =
    { tasks =
        [ Task 1 False "apply to internships"
        , Task 2 True "buy milk"
        , Task 3 False "finish this todo list"
        ]
    , newtask = ""
    , currentID = 4
    }
