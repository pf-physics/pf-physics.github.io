module Navigation exposing (..)

import Browser
import Browser.Navigation as Nav
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Css exposing (..)
import Css.Global
import Url
import Dict exposing (Dict)
import Url.Parser exposing (Parser, (</>), int, map, oneOf, s, string)
import Tab
import Tuple exposing (..)


-- MODEL


type Page
  = Main
  | Redshift
  | CV
  | APITest


viewTabs : Page -> Html msg
viewTabs page =
    div []
        [ Tab.tabsWrapper
            ( List.map (\p ->
                a
                [ if (Tuple.second p).page == page then Tab.activeCss else Tab.inactiveCss
                , href (Tuple.first p)
                ]
                [h3 [] [ text (Tuple.second p).name ] ]
                )
                pageList
            )
        ]


type alias PageInfo =
  { name : String
  , page : Page
  }


pageList: List (String, PageInfo)
pageList = [ ("", PageInfo "Home"  Main), ( "#CV", PageInfo "CV" CV) , ("#misc", PageInfo "Misc" APITest)] -- ("#redshift", Redshift),

pageMap: Dict String PageInfo
pageMap =
  Dict.fromList pageList


routeParser : Parser (Page -> a) a
routeParser =
  oneOf
    (List.map
        (\p -> Url.Parser.map (Tuple.second p).page (Url.Parser.s (Tuple.first p)) )
        pageList
    )
