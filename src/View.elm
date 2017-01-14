module View exposing (..)

import Html exposing (..)
import Html.Events exposing (onInput, onClick, onSubmit)
import Html.Attributes exposing (..)
import Models exposing (Msg(..), Model, Task)


view : Model -> Html Msg
view model =
    div []
        [ header
        , list model.tasks
        ]


header : Html Msg
header =
    div [ class "ui center aligned sizer vertical raised segment" ]
        [ div [ class "ui huge header" ] [ text " " ]
        , div [ class "ui huge teal header" ] [ text "to do:" ]
        , div [ class "ui large header" ] [ text " " ]
        , newTask
        ]


list : List Task -> Html Msg
list tasks =
    div [ class "ui raised very padded container segment" ]
        [ div [] (List.map taskRow tasks) ]


taskRow : Task -> Html Msg
taskRow task =
    div [ class "ui grid container" ]
        [ div [ class "ui four wide column" ] []
        , div [ class "ui seven wide column" ]
            [ div
                [ class "ui checkbox" ]
                [ input
                    [ type_ "checkbox"
                    , checked task.done
                    , onClick (ToggleCheck task.id)
                    ]
                    []
                , label []
                    [ (if task.editing then
                        editTask task
                       else
                        checkDone task
                      )
                    ]
                ]
            ]
        , div [ class "ui two wide column" ]
            [ editButton task
            , deleteTask task
            ]
        ]


editTask : Task -> Html Msg
editTask task =
    div [ class "ui small transparent input" ]
        [ Html.form
            [ type_ "submit"
            , class "ui form"
            , onSubmit (SaveEdit task.id)
            ]
            [ input
                [ type_ "text"
                , placeholder task.action
                , onInput EditTask
                ]
                []
            ]
        ]


deleteTask : Task -> Html Msg
deleteTask task =
    div
        [ class "ui teal mini icon button"
        , onClick (DeleteTask task.id)
        ]
        [ text "X" ]


editButton : Task -> Html Msg
editButton task =
    div
        [ class "ui teal mini icon button"
        , onClick
            (if (not task.editing) then
                ToggleEdit task.id
             else
                SaveEdit task.id
            )
        ]
        [ text "✎" ]


checkDone : Task -> Html Msg
checkDone task =
    if task.done then
        s [] [ text task.action ]
    else
        text task.action


newTask : Html Msg
newTask =
    div [ class "ui big input" ]
        [ Html.form
            [ type_ "submit"
            , class "ui form"
            , onSubmit AddTask
            ]
            [ input
                [ type_ "text"
                , placeholder "Add a new task!"
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
