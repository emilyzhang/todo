module Models exposing (..)


import Tasks.Models exposing (Task)


type alias Model =
    { tasks : List Task
    }


initialModel : Model
initialModel =
    { tasks = [ Task 1 5 "apply to internships" ]
    }
