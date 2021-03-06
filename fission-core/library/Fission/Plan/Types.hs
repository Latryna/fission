-- | User payment plans
module Fission.Plan.Types (Tier (..)) where

import           RIO.Text          as Text

import           Data.Aeson.Casing
import           Data.Swagger      as Swagger

import           Fission.Prelude

data Tier
  = Test
  | Free
  --  | Basic
  --  | Pro
  deriving ( Eq
           , Show
           , Generic
           )

instance Arbitrary Tier where
  arbitrary = elements [Test, Free]

instance ToJSON Tier where
  toJSON tier = String . Text.toLower . textDisplay $ displayShow tier

instance FromJSON Tier where
  parseJSON (String str) =
    case str of
      "Test" -> pure Test
      "test" -> pure Test

      "Free" -> pure Free
      "free" -> pure Free

      other  -> can'tParse other

  parseJSON other = can'tParse other

instance ToSchema Tier where
  declareNamedSchema =
    genericDeclareNamedSchema $ defaultSchemaOptions
      { Swagger.constructorTagModifier = camelCase }

can'tParse :: (MonadFail m, Show a) => a -> m b
can'tParse other = fail $ "Unable to parse " <> show other
