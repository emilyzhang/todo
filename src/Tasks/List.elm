module Tasks.List exposing (..)

import Html exposing (..)
import Html.Events exposing (onInput)
import Html.Attributes exposing (..)
import Tasks.Messages exposing (..)
import Tasks.Models exposing (Task)

view : List Task -> Html Msg
view tasks =
  div []
    [ header
    -- , newTask
    , list tasks ]


header : Html Msg
header =
  div [ class "ui center aligned sizer vertical raised segment" ]
      [ div [ class "ui huge header" ] [ text " " ]
      , div [ class "ui teal huge header" ] [ text "THE ULTIMATE TODO LIST" ]
      , div [ class "ui large header" ] [ text " " ]
      , newTask ]


list: List Task -> Html Msg
list tasks =
    div [ class "ui raised very padded container segment" ]
        [ div [ class "ui two column grid container raised segment"]
            [ div [ class "centered column center aligned black"] [ text "Priority"]
            , div [ class "centered column center aligned teal"] [ text "Task"] ] ]
        -- [ table []
        --   [ thead []
        --     [ th [] [ div [ class "column" ] [ div [] [ text "Id" ]] ]
        --     , th [] [ div [ class "column" ] [ div [] [ text "Priority" ]] ]
        --     , th [] [ div [ class "column" ] [ div [] [ text "Task" ]] ]
        --     ]
        --     , tbody [] (List.map taskRow tasks)
        --   ]
        -- ]

taskRow : Task -> Html Msg
taskRow task =
    div [ class "ui raised very padded text container" ]
        []
    -- tr [ class "four column doubling stackable grid container" ]
    --   [ td [ class "column" ] [ text (toString task.id) ]
    --   , td [ class "column" ] [ text (toString task.priority) ]
    --   , td [ class "column" ] [ text task.action ]
    --   , td [ class "column" ]
    --       []
    --   ]

newTask : Html Msg
newTask =
    div [ class "ui input " ]
        [ input [ type_ "text"
                , placeholder "Add a new task!"
                , onInput NewTask ] [] ]
