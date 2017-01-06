module Tasks.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Tasks.Messages exposing (..)
import Tasks.Models exposing (Task)

view : List Task -> Html Msg
view tasks =
  div []
    [ list tasks ]

list: List Task -> Html Msg
list tasks =
  div [ class "ui raised very padded text container segment" ]
      [ table []
        [ thead []
          [ th [] [ text "Id" ]
          , th [] [ text "Priority" ]
          , th [] [ text "Task" ]
          ]
          , tbody [] (List.map taskRow tasks)
        ]
      ]

taskRow : Task -> Html Msg
taskRow task =
  tr []
    [ td [] [ text task.id ]
    , td [] [ text (toString task.priority) ]
    , td [] [ text task.action ]
    , td []
        []
    ]
