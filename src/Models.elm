module Models exposing (..)

import Tasks.Models exposing (Task)


type alias Model =
    { tasks : List Task
    , newtask : String
    }


initialModel : Model
initialModel =
    { tasks =
        [ Task 1 5 "apply to internships"
        , Task 2 7 "buy milk"
        , Task 3 8 "finish this todo list"
        ]
    , newtask = ""
    }
