module Fission.Web.Server.IPFS.Pinner.Class (MonadIPFSPinner (..)) where

import           Fission.Prelude

import qualified Fission.Web.Server.IPFS.Cluster.Error as Cluster

import qualified Network.IPFS.Add.Error                as IPFS.Pin
import qualified Network.IPFS.Types                    as IPFS

type Errors' = OpenUnion
  '[ IPFS.Pin.Error
   , Cluster.Error
   ]

-- | A monad representing the ability to pin a cid to IPFS (cluster or invidual daemon)
class Monad m => MonadIPFSPinner m where
  pin :: IPFS.CID -> m (Either Errors' ())