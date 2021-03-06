package gs.preloading.workers
{
	import gs.events.AssetCompleteEvent;
	import gs.events.AssetProgressEvent;
	import gs.managers.AssetManager;
	import gs.preloading.Asset;

	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;

	/**
	 * The FLVWorker class loads progressive flv's with
	 * a net stream object.
	 * 
	 * @see gs.preloading.Preloader
	 * @see gs.managers.AssetManager
	 */
	final public class FLVWorker extends Worker
	{
		
		/**
		 * Net connection.
		 */
		private var nc:NetConnection;
		
		/**
		 * progress / complete interval.
		 */
		private var bt:Number;
		
		/**
		 * Timer for disposal.
		 */
		private var disposalTimer:Number;
		
		/**
		 * Load an asset of type flv.
		 */
		public override function load(asset:Asset):void
		{
			this.asset = asset;
			if(AssetManager.isAvailable(asset.source))
			{
				loader = AssetManager.getNetStream(asset.source);
				loader.client = this;
			}
			else
			{
				nc = new NetConnection();
				nc.connect(null);
				loader = new NetStream(nc);
				loader.client = this;
				loader.bufferTime = 100000;
				loader.soundTransform.volume = 0;
				AssetManager.addAsset(asset.source,loader,asset.source);
				AssetManager.addAsset(asset.libraryName,loader,asset.source);
				loader.play(asset.source);
				loader.pause();
			}
			bt = setInterval(check,200);
			asset.data = loader;
			loader.addEventListener(NetStatusEvent.NET_STATUS,onns,false,0,true);
			loader.addEventListener(AsyncErrorEvent.ASYNC_ERROR,onasync,false,0,true);
		}
		
		/**
		 * @private
		 */
		public function onMetaData(metadata:Object):void
		{
			AssetManager.saveFLVMetaData(this.asset.libraryName,metadata);
			AssetManager.saveFLVMetaData(this.asset.source,metadata);
		}
		
		/**
		 * @private
		 */
		public function onXMPData(xmpdata:*):void
		{
			AssetManager.saveFLVXMPMetaData(this.asset.libraryName,xmpdata);
			AssetManager.saveFLVXMPMetaData(this.asset.source,xmpdata);
		}
		
		//suppresses async errors
		private function onasync(a:AsyncErrorEvent):void{}
		
		/**
		 * Does progress and complete checks.
		 */
		private function check(te:TimerEvent=null):void
		{
			if(!loader) return;
			bytesLoaded=loader.bytesLoaded;
			bytesTotal=loader.bytesTotal;
			if(loader.bytesLoaded>=loader.bytesTotal)
			{
				clearInterval(bt);
				dispatchEvent(new AssetCompleteEvent(AssetCompleteEvent.COMPLETE,asset));
			}
			else dispatchEvent(new AssetProgressEvent(AssetProgressEvent.PROGRESS,asset));
		}
		
		/**
		 * removes event listeners.
		 */
		override protected function removeEventListeners():void
		{
			loader.removeEventListener(NetStatusEvent.NET_STATUS,onns);
			loader.removeEventListener(AsyncErrorEvent.ASYNC_ERROR,onasync);
		}
		
		/**
		 * On net status events.
		 */
		private function onns(stats:NetStatusEvent):void
		{
			switch(stats.info.code)
			{
				case "NetStream.Play.StreamNotFound":
					onIOLoadError(new IOErrorEvent(IOErrorEvent.IO_ERROR));
					clearInterval(bt);
					break;
			}
		}
		
		/**
		 * Dispose of this flv worker.
		 */
		override public function dispose():void
		{
			clearTimeout(disposalTimer);
			disposalTimer = setTimeout(disposeLater,10000);
		}
		
		private function disposeLater():void
		{
			removeEventListeners();
			clearInterval(bt);
			bt = NaN;
			bytesLoaded = NaN;
			bytesTotal = NaN;
			asset = null;
			loader = null;
			request = null;
			nc = null;
		}
	}
}