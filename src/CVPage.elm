module CVPage exposing (..)

import Html.Styled exposing (..)
import Html.Styled.Attributes as Att exposing (..)
import Html.Styled.Events exposing (..)
import Css exposing (..)
import File.Download as Download
import Bytes exposing (Bytes)
import Css.Global
import Json.Encode

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


viewTabs : Model -> Html Msg
viewTabs mdl =
  let
    tabStyles =
      css
        [ padding (px 25)
        , displayFlex
        , justifyContent center
        , Css.property "color" "white"
        , cursor pointer
        ]
    chosenTab tab =
      css (if mdl.tab == tab then [ border3 (px 2) solid (hex "757575"), borderRadius (px 20) ] else [])
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
    [ div [ onClick (SwitchTab Academic), tabStyles, chosenTab Academic] [ text "Academic"]
    , div [ onClick (SwitchTab Work), tabStyles, chosenTab Work] [ text "Work"]
    , div [ onClick (SwitchTab Hobbies), tabStyles, chosenTab Hobbies] [ text "Hobbies"]
    ]


abstract = """Black holes in dimensions > 4 can take on new properties and topologies
  compared to those in 4 dimensions. We examine the Myers-Perry black hole,
  a rotating black hole in D > 4 dimensions and take it to the ultra-spinning
  limit. In this limit, where the horizon exhibits two widely separated length scales,
  we explicitly show that Myers-Perry black holes are described by the blackfold
  effective theory up to first order in a derivative expansion. We conjecture that
  the second order blackfold approximation of Myers-Perry black holes can be
  obtained by applying the fluid/gravity correspondence. Using results obtained
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
    [ h3 []
      [ text "I am currently working as a software developer at "
      , a [ href "https://www.smallbrooks.com/", Att.target "_blank"] [ text "Smallbrooks" ]
      , text " working on crowdfunding platforms."
      , p [] 
        [ text "An example of one of the platforms we've made is "
        , a [ href "https://crowdfunding.coop.dk/", Att.target "_blank" ] [ text "Coop Crowdfunding"]
        , text " which provides a great way of getting new products on the market, allowing for the general crowd to support farms and businesses."
        ]
      ]
    , button [ onClick DownloadFile, css buttonStyles ] [ text "Download CV" ]
    ]


viewHobbies : Html msg
viewHobbies =
  div [ css [margin2 (px 0) (px 30)] ]
    [ h3 [] [ text "Hobbies"]
    , h4 [] [ text "I enjoy singing in choir or on my own. Currently I am a part of the "
            , a [ href "https://bachkoret.dk/", Att.target "_blank"] [ text "Københavns Bachkor" ]
            , text ". Unfortunately because of Corona, I've only had one concert with them."]
    , h4 [] [ text "Previously, I sung with Les Muses Chorale while studying at McGill University."]
    , iframe
      [ Att.width 560
      , Att.height 100
      , css [ Css.marginBottom (Css.px 30)]
      , src "https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/450199737&color=%233a3a3a&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true&visual=true"
      , Att.property "frameborder" (Json.Encode.string "0")
      , Att.property "allowfullscreen" (Json.Encode.string "true")
      ]
      []
    , h4 [] [ text "I also enjoy video making/editing"]
    , iframe
        [ Att.width 560
        , Att.height 315
        , css [ Css.marginBottom (Css.px 30)]
        , src "https://www.youtube.com/embed/ZAe2AKLzVSw"
        , Att.property "frameborder" (Json.Encode.string "0")
        , Att.property "allowfullscreen" (Json.Encode.string "true")
        ]
        []
    ]




view : Model -> Html Msg
view mdl =
  div []
  [ h1 [css [displayFlex, justifyContent center] ] [ text "Experience" ]
    , h4 [css [displayFlex, justifyContent center]] [text "Note - these pages are still under construction"]
    , div [ css [ displayFlex, padding (px 10) ] ]
      [ viewTabs mdl
      , div [ css [ displayFlex, paddingLeft (px 50), justifyContent left, Css.width (pct 100)] ] 
        [ case mdl.tab of
          Academic -> viewAcademic
          Work -> viewWork
          Hobbies -> viewHobbies
        ]
      ]
  ]
