module Tab exposing (..)

import Css exposing (..)
import Html.Styled as Html exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)


activeCss: Attribute msg
activeCss =
    css
        [ Css.width (px 120)
        , displayFlex
        , justifyContent center
        , Css.property "color" "white"
        , textDecoration none
        , backgroundColor (hex "#616161")
        , padding (px 10)
        ]

inactiveCss : Attribute msg
inactiveCss =
    css
        [ Css.width (px 120)
        , displayFlex
        , justifyContent center
        , Css.property "color" "white"
        , textDecoration none
        , padding (px 10)
        ]


{--
taken from:
https://elmcsspatterns.io/navigation/tab
--}
tabsWrapper : List (Html msg) -> Html msg
tabsWrapper tabs =
    div
        [ css
            [ displayFlex
            , alignItems center
            , justifyContent left
            --, border3 (px 3) solid (hex "efefef")
            , backgroundColor (hex "#424242")
            , boxShadow5 (px 0) (px 0) (px 5) (px 0) (hex "#777")
            ]
        ]
        tabs