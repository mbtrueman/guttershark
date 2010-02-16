package gs.util.filters{	import flash.display.DisplayObject;	import flash.filters.BevelFilter;	import flash.filters.BitmapFilter;	import flash.filters.BlurFilter;	import flash.filters.ColorMatrixFilter;	import flash.filters.DropShadowFilter;	import flash.filters.GlowFilter;	import flash.filters.GradientBevelFilter;	import flash.filters.GradientGlowFilter;	import flash.utils.Dictionary;	/**	 * The FilterUtilities class is contains common filter generation and filter	 * management for a display object.	 * 	 * <script src="http://mint.codeendeavor.com/?js" type="text/javascript"></script>	 */	public class FilterUtils 	{				/**		 * Filters storage.		 */		private static var filters:Dictionary = new Dictionary(true);				/**		 * Save a filter for later use, by id.		 * 		 * @param id The id of the filter.		 * @param filter Any filter.		 */		public static function set(id:String,filter:*):void		{			if(!id)throw new ArgumentError("Parameter {id} cannot be null");			if(!filter)throw new ArgumentError("Parameter {filter} cannot be null");			filters[id]=filter;		}				/**		 * Get a filter that was previously saved.		 * 		 * @param id The filter id.		 */		public static function get(id:String):*		{			if(!filters[id]) return null;			return filters[id];		}				/**		 * Unset (delete) a filter.		 * 		 * @param id The filter id.		 */		public static function unset(id:String):void		{			delete filters[id];		}				/**		 * Return a default <code>DropShadowFilter</code>.		 * <ul>		 * <li>length:0</li>		 * <li>direction:45</li>		 * <li>alpha:100</li>		 * <li>blurX:10</li>		 * <li>blurY:10</li>		 * <li>strength:0.5</li>		 * <li>quality:HIGH</li>		 * </ul>		 */		public static function getSoftShadowFilter():DropShadowFilter		{			return new DropShadowFilter(0,45,0x000000,100,10,10,0.50,FilterQuality.HIGH);		}		/**		 * Returns a predefined greyscale color matrix.		 */		public static function luminanceTransform():ColorMatrixFilter 		{			var rwgt:Number=.3086;			var gwgt:Number=.6094;			var bwgt:Number=.0820;			var lumTransform:ColorMatrixFilter=new ColorMatrixFilter(new Array(rwgt,gwgt,bwgt,0.0,0.0,rwgt,gwgt,bwgt,0.0,0.0,rwgt,gwgt,bwgt,0.0,0.0,0.0,0.0,0.0,1.0,0.0));			return lumTransform;		}			/**		 * Clears any current shadow filters, and applies a new one.		 * 		 * @param target The target display object.		 * @param filter A drop shadow filter.		 */		public static function setShadow(target:DisplayObject,filter:DropShadowFilter):DropShadowFilter 		{			clearFilterType(target,DropShadowFilter);			return addShadow(target,filter);		}		/**		 * Adds a new shadow filter to the display object.		 * 		 * @param target The target display object.		 * @param filter A drop shadow filter. 		 */		public static function addShadow(target:DisplayObject,filter:DropShadowFilter):DropShadowFilter 		{			addFilter(target,filter);			return filter;		}		/**		 * Remove all shadow filters.		 * 		 * @param The target display object.		 */		public static function cleanShadow(target:DisplayObject):void		{			clearFilterType(target,DropShadowFilter);		}		/**		 * Clears any current glow filters, and applies a new one.		 * 		 * @param target The target display object.		 * @param filter A glow filter.		 */		public static function setGlow(target:DisplayObject,filter:GlowFilter):GlowFilter 		{			clearFilterType(target,GlowFilter);			return addGlow(target,filter);		}		/**		 * Adds a new glow filter to the display object.		 * 		 * @param target The target display object.		 * @param filter A glow filter.		 */		public static function addGlow(target:DisplayObject,filter:GlowFilter):GlowFilter		{			addFilter(target,filter);			return filter;		}		/**		 * Remove all glow filters.		 * 		 * @param target The target display object.		 */		public static function cleanGlow(target:DisplayObject):void 		{			clearFilterType(target,GlowFilter);		}		/**		 * Clears any current bevel filters, and applies a new one.		 * 		 * @param target The target display object.		 * @param filter A bevel filter.		 */		public static function setBevel(target:DisplayObject,filter:BevelFilter):BevelFilter 		{			clearFilterType(target,BevelFilter);			return addBevel(target,filter);		}		/**		 * Adds a new bevel filter to the display object.		 * 		 * @param target The target display object.		 * @param filter A bevel filter.		 */		public static function addBevel(target:DisplayObject,filter:BevelFilter):BevelFilter 		{			addFilter(target,filter);			return filter;		}		/**		 * Remove all bevel filters.		 * 		 * @param target The target display object.		 */		public static function cleanBevel(target:DisplayObject):void 		{			clearFilterType(target,BevelFilter);		}		/**		 * Clears any current color filters, and applies a new one.		 * 		 * @param target The target display object.		 * @param filter A color matrix filter.		 */		public function setColorMatrix(target:DisplayObject,filter:ColorMatrixFilter):ColorMatrixFilter 		{			clearFilterType(target,ColorMatrixFilter);			return addColorMatrix(target,filter);		}		/**		 * Adds a new color matrix filter to the display object.		 * 		 * @param target The target display object.		 * @param filter A color matrix filter.		 */		public static function addColorMatrix(target:DisplayObject,filter:ColorMatrixFilter):ColorMatrixFilter 		{			addFilter(target,filter);			return filter;		}		/**		 * Clears any gradient glow filters, and applies a new one.		 * 		 * @param target The target display object.		 * @param filter A gradient glow filter.		 */		public static function setGradientGlow(target:DisplayObject,filter:GradientGlowFilter):GradientGlowFilter 		{			clearFilterType(target,GradientGlowFilter);			return addGradientGlow(target,filter);		}				/**		 * Adds a new gradient glow filter to the display object.		 * 		 * @param target The target display object.		 * @param filter A gradient glow filter.		 */		public static function addGradientGlow(target:DisplayObject,filter:GradientGlowFilter):GradientGlowFilter		{			addFilter(target,filter);			return filter;		}		/**		 * Remove all gradient glow filters.		 * 		 * @param target The target display object.		 */		public static function cleanGradientGlow(target:DisplayObject):void 		{			clearFilterType(target,GradientGlowFilter);		}		/**		 * Clears any gradient bevel filters, and applies a new one.		 * 		 * @param target The target display object.		 * @param filter A gradient bevel filter.		 */		public static function setGradientBevel(target:DisplayObject,filter:GradientBevelFilter):GradientBevelFilter		{			clearFilterType(target,GradientBevelFilter);			return addGradientBevel(target,filter);		}		/**		 * Adds a new gradient bevel filter to the display object.		 * 		 * @param target The target display object.		 * @param filter A gradient bevel filter.		 */		public static function addGradientBevel(target:DisplayObject,filter:GradientBevelFilter):GradientBevelFilter		{			addFilter(target,filter);			return filter;		}		/**		 * Remove all gradient bevel filters.		 * 		 * @param target The target display object.		 */		public static function cleanGradientBevel(target:DisplayObject):void 		{			clearFilterType(target,GradientBevelFilter);		}		/**		 * Clears any blur filters, and applies a new one.		 * 		 * @param target The taget display object.		 * @param filter A blur filter.		 */		public static function setBlur(target:DisplayObject,filter:BlurFilter):BlurFilter		{			clearFilterType(target,BlurFilter);			return addBlur(target,filter);		}		/**		 * Adds a new blur filter the the display object.		 * 		 * @param target The target display object.		 * @param filter A blur filter.		 */		public static function addBlur(target:DisplayObject,filter:BlurFilter):BlurFilter		{			addFilter(target,filter);			return filter;		}		/**		 * Remove all blur filters.		 * 		 * @param target The target display object.		 */		public static function cleanBlur(target:DisplayObject):void		{			clearFilterType(target,BlurFilter);		}		/**		 * Add a filter of any type, to the target display object.		 * 		 * @param taget The target display object.		 * @param filter A bitmap filter.		 */		public static function addFilter(target:DisplayObject=null,filter:BitmapFilter=null):void 		{			if(target == null||filter == null) return;			var tmp:Array=target.filters;			tmp.push(filter);			target.filters=tmp;		}		/**		 * Remove a filter of any type.		 * 		 * @param target The target display object.		 * @param filter A bitmap filter.		 */		public static function removeFilter(target:DisplayObject=null,filter:BitmapFilter=null):void 		{			if(target == null||filter == null ) return;			var tmp:Array=target.filters;			var index:int=getFilterIndex(target,filter);			if(index > -1)			{				tmp.splice(index,1);                				target.filters=tmp;			}		}		/**		 * Remove all filters from a target display object.		 * 		 * @param target The target display object.		 */		public static function clean(target:DisplayObject):void 		{			target.filters=[];		}		/**		 * Removes all filters of a certain type.		 * 		 * @param target The target display object.		 * @param filterType The class type of the filters to remove.		 */		public static function clearFilterType(target:DisplayObject=null,filterType:Class=null):void 		{			if(target == null||filterType == null) return;			var len:int=target.filters.length;			var tmp:Array=new Array();			var i:int=0;			for(i;i<len;i++) 			{				var f:BitmapFilter=target.filters[i];				if(!(f is filterType)) tmp.push(f);			}			target.filters=tmp;		}		/**		 * Finds the last index of a filter and returns that index, or -1 if not found.		 * 		 * @param target The target display object.		 * @param filter A bitmap filter.		 */		public static function getFilterIndex(target:DisplayObject=null,filter:BitmapFilter=null):int 		{			if(target == null) return -1;			var pos:int=target.filters.length;			while(pos--)			{				var f:BitmapFilter=target.filters[pos];				if(f == filter) return pos;			}			return -1;		}		/**		 * Finds the last index of a filter type, and returns that index, or -1 if not found.		 * 		 * @param target The target display object.		 * @param filterType The class type of the filter to find.		 */		public static function getFilterTypeIndex(target:DisplayObject=null,filterType:Class=null):int		{			if(target == null) return -1;			var pos:int=target.filters.length;			while(pos--)			{				var f:BitmapFilter=target.filters[pos];				if(f is filterType) return pos;			}			return -1;		}			}}