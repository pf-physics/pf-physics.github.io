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


downloadThesis : Cmd msg
downloadThesis =
  Download.url "Files/thesis.pdf"


saveFrog : Cmd msg
saveFrog =
  Download.url "Files/frog.jpg"

-- UPDATE

type Msg
  = DownloadFrog
  | DownloadFile
  | SwitchTab Tab
  | DownloadThesis


update : Msg -> Model -> (Model, Cmd Msg)
update msg mdl =
  case msg of
    DownloadFile ->
      (mdl, downloadCV)

    DownloadThesis ->
      (mdl, downloadThesis)

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
  | Halloween

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
    , div [ onClick (SwitchTab Halloween), tabStyles, chosenTab Halloween] [ text "Halloween"]
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
  , br [] []
  , button [ onClick DownloadThesis, css buttonStyles ] [ text "Download Thesis" ]
  ]


viewWork : Html Msg
viewWork =
  div [ css [ displayFlex, flexDirection column, justifyContent left, margin2 (px 0) (px 30)] ]
    [ h3 []
      [ text "My most recent position was at "
      , a [ href "https://www.smallbrooks.com/", Att.target "_blank"] [ text "Smallbrooks" ]
      , text " where I was employed as a software developer, working on crowdfunding platforms."
      , p []
        [ text "An example of one of the platforms we've made is "
        , a [ href "https://crowdfunding.coop.dk/", Att.target "_blank" ] [ text "Coop Crowdfunding"]
        , text " which provides a great way of getting new products on the market, allowing for the general crowd to support farms and small businesses."
        ]
      ]
    , button [ onClick DownloadFile, css buttonStyles ] [ text "Download CV" ]
    ]


viewHalloween : Html msg
viewHalloween =
  div [ css [margin2 (px 0) (px 30)] ] [
    h2 [] [ text "Halloween"]
    , h4 [] [ text "One of my hobbies is event planning, specifically for Halloween (though occasionally I will organize events for other holidays/themes). For the past few years I have organized elaborate Halloween parties with an accompanying app. The app presents the players with a story, along with tasks they must complete to progress the plot. Most of the 'tasks' are Halloween games I've come up with (complete with drinking rules), along with some riddle solving. The apps cannot be played without the real life activities, but one can still explore the apps with the codes provided on the github page. The web apps were designed for mobile, but still work fine on desktop." ]
    , h3 [] [ a [ href "https://pf-physics.github.io/halloween2021/"] [ text "Halloween 2021"]]
    , h4 [] [ text "The premise of the party (sent to the guests before arriving) is as follows:"
            , p [] [ text "\"It is a dark and stormy night, you and your friends are heading for a Halloween party. Your car, which somehow fits 13 people, suddenly breaks down. There is no phone service this far out into the Danish woods. Luckily, you spy a looming manor in the distance. Making your way over you are greeted inside by a strange looking host...\""]
            , text "The host, a strange insect looking creature, greets the guests as if they were all old friends while admitting that his vision has deteriorated. He insists they stay for the evening. In order not to arouse suspicion of their human nature the group complies. The groups make their way through the rooms, entertaining their host's whims by playing games. When their host's back is turned they encounter his REAL friends, who express their disdain for the old man. Upon visiting the oracle, the guests learn that there is a strange dark power in the manor and urges them to investigate. If the guests lose enough health (by performing badly in games), they will become ghosts and attempt to turn the remaining guests into ghosts as well."
            , text " The app was made in React." ]
    , h3 [] [ a [ href "https://pf-physics.github.io/halloween2020/"] [ text "Halloween 2020"] ]
    , h4 [] [ text "In 2020, Halloween fell on a full moon and the event revolved around this fact. The guests are split up into two groups: mystics (consisting of witches, vampires and werewolves) and undead (skeletons, zombies, ghosts). Both groups are informed separately that, although the moon is full, its power is dull and that the OTHER group is responsible for its state. To solve this dispute, a series of challenges have been put forth to determine which group is superior. As they complete challenges, they find evidence that something much darker could be responsible for the moon's weakness. Depending on the species, different abilities are gained to interfere with the other team. The app was made in React" ]
    , h3 [] [ a [ href "https://play.google.com/store/apps/details?id=com.HalloweenInc.HalloweenApp"] [ text "Halloween 2019"] ]
    , h4 [] [ text "Upon arriving, the guests are informed that different dimensions have been embedded into different rooms of the house. To find out why this happened, they must perform tasks in each dimension. As they investigate, they learn of a young girl who died in the house long ago, whose soul has gone missing..."
    , p [] [ text "The first few codes are: pumpkin031, wizard, rat, (in the vampire dimension, play the exorcist theme song), (in the ghost dimension, choose any answers). With the help of Daniel Lozano, we made an android app for the google play store." ]
    ]
  ]

viewHobbies : Html msg
viewHobbies =
  div [ css [margin2 (px 0) (px 30)] ]
    [ h1 [] [ text "Hobbies"]
    , h4 [] [ text "I enjoy singing in choir or on my own. Most recently I was a part of the "
            , a [ href "https://bachkoret.dk/", Att.target "_blank"] [ text "Københavns Bachkor" ]
            , text ". Because of Corona, I had fewer concerts with them than planned but enjoyed performing the Bach Christmas Oratorio with them in 2019 and 2021."]
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
    , h3 [] [ text "I also enjoy video making/editing"]
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
          Halloween -> viewHalloween
        ]
      ]
  ]
