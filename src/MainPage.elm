module MainPage exposing (..)

import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Css exposing (..)
import Css.Global

-- MODEL
type alias Model =
  { test : String
  , message : Maybe String
  }


init : () -> (Model, Cmd Msg)
init _ =
  ( Model "Starting it up" Nothing
  , Cmd.none
  )



-- UPDATE

type Msg
  = Something String


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Something s -> ( model, Cmd.none )


-- VIEW


view : Model -> Html Msg
view model =
  div [ css [padding (px 30)] ]
  [ h1 [css [displayFlex, justifyContent center, paddingBottom (px 50)] ] [ text "Sacha Perry-Fagant" ]
  -- , h2 [css [displayFlex, justifyContent center] ] [ text "Welcome" ]
  , div [ css [ displayFlex, justifyContent left ] ]
    [ div [css [ displayFlex, justifyContent center, Css.width (pct 100)] ]  [ img [ src "Files/SPF.jpg", css [Css.height (px 300)]] [] ]
    , p [ css [ fontSize (px 20), Css.width (pct 200)] ]
      [ p [] [text "I am a physicist and software developer interested in cosmology and gravity."]
      , p [] [text "I am currently searching for a PhD in physics"]
      ]
    ]
  ]
