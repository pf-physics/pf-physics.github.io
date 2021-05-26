module CVPage exposing (..)

import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Css exposing (..)
import File.Download as Download
import Bytes exposing (Bytes)
import Css.Global

-- MODEL
type alias Model =
  { test : String
  , message : Maybe String
  , tab : Tab
  }


init : () -> (Model, Cmd Msg)
init _ =
  ( Model "Starting it up" Nothing Academic
  , Cmd.none
  )


downloadCV : Cmd msg
downloadCV =
  Download.url "Files/CV.pdf"


saveFrog : Cmd msg
saveFrog =
  Download.url "Files/frog.jpg"

-- UPDATE

type Msg
  = DownloadFrog
  | DownloadFile
  | SwitchTab Tab


update : Msg -> Model -> (Model, Cmd Msg)
update msg mdl =
  case msg of
    DownloadFile ->
      (mdl, downloadCV)

    DownloadFrog ->
      (mdl, saveFrog)

    SwitchTab tab ->
      ( {mdl | tab = tab }, Cmd.none)



buttonStyles : List Style
buttonStyles =
  [ padding2 (px 10) (px 25)
  , fontSize (px 20)
  , fontWeight bold
  , Css.color (hex "#ffffff")
  , backgroundColor (hex "#530082")
  , borderRadius (px 6)
  , border3 (px 1) solid (hex "#3f0e48")
  , Css.property "font-family" "calibri"
  , cursor pointer
  , maxHeight (px 60)
  , maxWidth (px 200)
  , hover
    [ Css.backgroundColor (hex "#380057")
    , borderRadius (px 10)
    ]
  ]

type Tab
  = Academic
  | Work
  | Hobbies

-- VIEW


viewTabs : Html Msg
viewTabs =
  let
    tabStyles =
      css
        [ padding (px 25)
        , displayFlex
        , justifyContent center
        , Css.property "color" "white"
        , cursor pointer
        ]
  in
  div 
    [ css
      [displayFlex
      , flexDirection column
      , Css.width (pct 10)
      , borderRadius (px 20)
      , backgroundColor (hex "#424242")
      , fontWeight bold
      , Css.height (pct 100)
      ]
    ]
    [ div [ onClick (SwitchTab Academic), tabStyles] [ text "Academic"]
    , div [ onClick (SwitchTab Work), tabStyles] [ text "Work"]
    , div [ onClick (SwitchTab Hobbies), tabStyles] [ text "Hobbies"]
    ]


abstract = """Black holes in dimensions > 4 can take on new properties and topologies
  compared to those in 4 dimensions. We examine the Myers-Perry black hole,
  a rotating black hole in D > 4 dimensions and take it to the ultra-spinning
  limit. In this limit, where the horizon exhibits two widely separated length scales,
  we explicitly show that Myers-Perry black holes are described by the blackfold
  eective theory up to rst order in a derivative expansion. We conjecture that
  the second order blackfold approximation of Myers-Perry black holes can be
  obtained by applying the 
  uid/gravity correspondence. Using results obtained
  in this manner, we examine the expected higher order metrics and associated
  energy-momentum tensors. We review the comparison of the Gregory-La
  amme
  instability to hydrodynamic perturbations."""

viewAcademic : Html Msg
viewAcademic =
  div [ css [margin4 (px 0) (px 60) (px 0) (px 30)]]
  [ h3 [] [ text "My academic interests and experience lie in theoretical and computational physics"]
  , h2 [] [ text "Master's thesis:"]
  , h3 [] [ text "Abstract" ]
  , p [] [ text abstract]
  ]


viewWork : Html Msg
viewWork =
  div [ css [ displayFlex, flexDirection column, justifyContent left, margin2 (px 0) (px 30)] ]
    [ h3 [] [ text "I am currently working as a software developer "]
    , button [ onClick DownloadFile, css buttonStyles ] [ text "Download CV" ]
    ]



view : Model -> Html Msg
view mdl =
  div []
  [ h1 [css [displayFlex, justifyContent center] ] [ text "Experience" ]
    , h4 [css [displayFlex, justifyContent center]] [text "Note - these pages are still under construction"]
    , div [ css [ displayFlex, padding (px 10) ] ]
      [ viewTabs
      , div [ css [ displayFlex, paddingLeft (px 50), justifyContent left, Css.width (pct 100)] ] 
        [ case mdl.tab of
          Academic -> viewAcademic
          Work -> viewWork
          Hobbies -> text "Under construction"
        ]
      ]
  ]
