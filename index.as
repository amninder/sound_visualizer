package  {
	
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.media.SoundMixer;
	import flash.display.Sprite;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
		
	public class index extends MovieClip {
		
		public var ba:ByteArray = new ByteArray();
		public var s:Sound = new Sound(new URLRequest("electronica.mp3"));
		public var effectSprite:Sprite;
		public var bmd:BitmapData;
		public var bm:Bitmap;
		public var blurFilter:BlurFilter;
		public var colorMatrix:ColorMatrixFilter;
		public function index() {
			s.play(0, 1000);
			this.bmd = new BitmapData(this.stage.stageWidth, this.stage.stageHeight, true, 0x000000);
			this.bm = new Bitmap(this.bmd);
			this.effectSprite = new Sprite();
			this.blurFilter = new BlurFilter(7, 7, 3);
			this.colorMatrix = new ColorMatrixFilter ([
				1, 0, 0, 0, 0,
				0, 0.5, 0, 0, 0,
				0, 0, 1, 0, 0,
				0, 0, 0, 1, 0
			]);
			this.stage.scaleMode = "exactFit";
			this.stage.align = "TL";
			this.addChild(this.bm);
			this.addChild(this.effectSprite);
			addEventListener(Event.ENTER_FRAME, loop);
		}
		function loop(e:Event){
			this.effectSprite.graphics.clear();
			this.effectSprite.graphics.lineStyle(1, 0xFFFFFF);
			this.effectSprite.graphics.moveTo(-1, this.stage.stageHeight/2);
			SoundMixer.computeSpectrum(ba);
			this.bmd.draw(this);
			for(var i:uint=0; i<256; i++){
				var num:Number = ba.readFloat()*this.stage.stageHeight/2 + this.stage.stageHeight/2;
				//this.effectSprite.graphics.drawCircle(i*(this.stage.stageWidth / 256), num, 1);
				this.effectSprite.graphics.lineTo(i*(this.stage.stageWidth/256), num);
			}
			this.effectSprite.graphics.lineTo(this.stage.stageWidth+1, this.stage.stageHeight/2);
			this.bmd.draw(this.effectSprite);
			this.bmd.applyFilter(this.bmd, this.bmd.rect, new Point(), this.blurFilter);
			this.bmd.applyFilter(this.bmd, this.bmd.rect, new Point(), this.colorMatrix);
			this.bmd.scroll(2, 0);
		}
	}
	
}
