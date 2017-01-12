module TaskList exposing (..)

import Html exposing (..)
import Html.Events exposing (onInput, onClick, onSubmit)
import Html.Attributes exposing (..)


-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- INIT


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


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



-- MODELS


type alias Model =
    { tasks : List Task
    , newtask : String
    , currentID : Int
    }


type alias TaskId =
    Int


type alias Task =
    { id : TaskId
    , done : Bool
    , action : String
    }



-- MESSAGES


type Msg
    = CreateTask String
    | AddTask
    | DeleteTask TaskId



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        CreateTask writetask ->
            ( { model | newtask = writetask }, Cmd.none )

        AddTask ->
            if model.newtask == "" then
                ( model, Cmd.none )
            else
                ( { model | tasks = Task model.currentID False model.newtask :: model.tasks }, Cmd.none )

        DeleteTask taskId ->
            let
                newlist =
                    List.filter (\t -> t.id /= taskId) model.tasks
            in
                ( { model | tasks = newlist }, Cmd.none )



-- VIEW


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
                [ input [ type_ "checkbox" ] []
                , label [ class "column" ] [ text task.action ]
                ]
            ]
        , div [ class "ui column" ]
            [ div
                [ class "ui teal mini icon button"
                , onClick (DeleteTask task.id)
                ]
                [ text "X" ]
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
