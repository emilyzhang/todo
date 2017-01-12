module Tasks.List exposing (..)

import Html exposing (..)
import Html.Events exposing (onInput, onClick, onSubmit)
import Html.Attributes exposing (..)
import Tasks.Messages exposing (..)
import Tasks.Models exposing (Task)


view : List Task -> Html Msg
view tasks =
    div []
        [ header
        , list tasks
        ]


header : Html Msg
header =
    div [ class "ui center aligned sizer vertical raised segment" ]
        [ div [ class "ui huge header" ] [ text " " ]
        , div [ class "ui teal huge header" ] [ text "to do:" ]
        , div [ class "ui large header" ] [ text " " ]
        , newTask
        ]


list : List Task -> Html Msg
list tasks =
    div [ class "ui raised very padded container segment" ]
        [ div [] (List.map taskRow tasks) ]


taskRow : Task -> Html Msg
taskRow task =
    div [ class "ui column grid container" ]
        [ div [ class "center aligned column" ]
            [ div [ class "ui checkbox" ]
                [ input [ type_ "checkbox" ] []
                , label [] [ text task.action ]
                ]
            ]
        ]


newTask : Html Msg
newTask =
    div [ class "ui big action input" ]
        [ Html.form
            [ type_ "submit"
            , class "ui form"
            , placeholder "Add a new task!"
            , onSubmit AddTask
            ]
            [ input
                [ type_ "text"
                , placeholder "Add a new task!"
                  -- , value Model
                , onInput CreateTask
                ]
                []
            ]
        , button
            [ type_ "submit"
            , class "ui teal button"
            , onClick AddTask
            ]
            [ text "+" ]
        ]
