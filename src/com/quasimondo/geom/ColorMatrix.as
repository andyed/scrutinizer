/**
* ColorMatrix
* 
* Based on Mario Klingemann's wonderful AS2 ColorMatrix Class
* 
* @author Copyright Mario Klingemann and muta
* 
* @see http://www.quasimondo.com/
* @see http://www.quasimondo.com/archives/000565.php
* 
* @see http://www.graficaobscura.com/matrix/
* @see http://www.graficaobscura.com/matrix/matrix.c
* 
* @see http://unbland.net/blog/
* 
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
* 
* http://www.apache.org/licenses/LICENSE-2.0
* 
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
* either express or implied. See the License for the specific language
* governing permissions and limitations under the License.
*/

package com.quasimondo.geom {
	
	public class ColorMatrix {
		
		private const LUM_R:Number = 0.212671;
		private const LUM_G:Number = 0.715160;
		private const LUM_B:Number = 0.072169;
		
		/**
		* 新しい ColorMatrix インスタンスを作成します。
		* 
		* @param colorMatrix ColorMatrix オブジェクト、もしくは 5×4 の 20 個の行列からなる Array オブジェクトです。
		*/
		public function ColorMatrix(colorMatrix:* = null) {
			if(colorMatrix) {
				if(colorMatrix is ColorMatrix) _matrix = colorMatrix.matrix;
				else if(colorMatrix is Array) {
					if(colorMatrix.length == 20) _matrix = colorMatrix;
					else throwError();
				}
				else throwError();
			} else {
				identity();
			}
		}
		
		/**
		* 5×4 の　20 個の行列からなる Array オブジェクトです。
		*/
		public function get matrix():Array {
			return _matrix.concat();
		}
		private var _matrix:Array;
		
		/**
		* 色相 (Hue) 彩度 (Saturation) 明度 (Brightness) コントラスト (Contrast)　を一括で変更します。
		* 
		* @param hue -180 <- 0 -> 180 の範囲で変更します。
		* @param saturation 0 以上で変更します。
		* @param brightness -1 <- 0 -> 1 の範囲で変更します。
		* @param contrast -1 <- 0 -> 1 の範囲で変更します。
		*/
		public function adjustColor(hue:Number, saturation:Number, brightness:Number, contrast:Number):void {
			identity();
			adjustHue(hue);
			adjustSaturation(saturation);
			adjustBrightness(brightness);
			adjustContrast(contrast);
		}
		
		/**
		* 色相 (Hue) を変更します。
		* 
		* @param value -180 <- 0 -> 180 の範囲で指定します。
		*/
		public function adjustHue(value:Number):void {
			var lumR:Number = LUM_R;
			var lumG:Number = LUM_G;
			var lumB:Number = LUM_B;
			
			var radians:Number = value * Math.PI / 180;
			
			var cos:Number = Math.cos(radians);
            var sin:Number = Math.sin(radians);
			
            concat([
				lumR + cos * (1 - lumR) + sin * -lumR      , lumG + cos * -lumG      + sin * -lumG, lumB + cos * -lumB      + sin * (1 - lumB), 0, 0,
				lumR + cos * -lumR      + sin * 0.143      , lumG + cos * (1 - lumG) + sin * 0.140, lumB + cos * -lumB      + sin * -0.283    , 0, 0,
				lumR + cos * -lumR      + sin * -(1 - lumR), lumG + cos * -lumG      + sin * lumG , lumB + cos * (1 - lumB) + sin * lumB      , 0, 0,
				0, 0, 0, 1, 0
			]);
		}
		
		/**
		* 彩度 (Saturation) を変更します。
		* 0 の時にグレースケールになります。
		* 
		* @param value 0 以上を指定します。
		*/
		public function adjustSaturation(value:Number):void {
			var n:Number = 1 - value;
			
			var r:Number = LUM_R * n;
			var g:Number = LUM_G * n;
			var b:Number = LUM_B * n;
			
			concat([
				r + value, g        , b        , 0, 0,
				r        , g + value, b        , 0, 0,
				r        , g        , b + value, 0, 0,
				0, 0, 0, 1, 0
			]);
		}
		
		/**
		* 明度 (Brightness) を変更します。
		* 
		* @param value -1 <- 0 -> 1 の範囲で指定します。
		*/
		public function adjustBrightness(value:Number):void {
			concat([
				1, 0, 0, value, 0,
				0, 1, 0, value, 0,
				0, 0, 1, value, 0,
				0, 0, 0, 1, 0
			]);
		}
		
		/**
		* コントラスト (Contrast) を変更します。
		* 
		* @param value -1 <- 0 -> 1 の範囲で指定します。
		*/
		public function adjustContrast(value:Number):void {
			concat([
				value + 1, 0        , 0        , 0, -(128 * value),
				0        , value + 1, 0        , 0, -(128 * value),
				0        ,      0   , value + 1, 0, -(128 * value),
				0, 0, 0, 1, 0
			]);
		}
		
		/**
		* 指定の色で着色します。
		* 
		* @param rgb 着色する色です。
		* @param amount 着色する度合いです。
		*/
		public function colorize(rgb:uint, amount:Number = 1):void {
			var lumR:Number = LUM_R;
			var lumG:Number = LUM_G;
			var lumB:Number = LUM_B;
			
			var n:Number = 1 - amount;
			
			var r:uint = rgb >> 16 & 0xff / 255;
			var g:uint = rgb >> 8  & 0xff / 255;
			var b:uint = rgb       & 0xff / 255;
			
			concat([
				n + amount * r * lumR, amount * r * lumG    , amount * r * lumB    , 0, 0,
				amount * g * lumR    , n + amount * g * lumG, amount * g * lumB    , 0, 0,
				amount * b * lumR    , amount * b * lumG    , n + amount * b * lumB, 0, 0,
				0, 0, 0, 1, 0
			]);
		}
		
		/**
		* 指定のしきい値を元に、範囲内に収まっているものは黒、超えているものは白に区別します。
		* 
		* @param value しきい値です。
		*/
		public function threshold(value:Number):void {
			var lumR:Number = LUM_R;
			var lumG:Number = LUM_G;
			var lumB:Number = LUM_B;
			
			concat([
				lumR * 256, lumG * 256, lumB * 256, 0, -256 * value, 
				lumR * 256, lumG * 256, lumB * 256, 0, -256 * value, 
				lumR * 256, lumG * 256, lumB * 256, 0, -256 * value, 
				0, 0, 0, 1, 0
			]);
		}
		
		/**
		* 色調をランダムで変更します。
		* 
		* @param value ランダムで変更する度合いです。
		*/
		public function randomize(amount:Number = 1):void {
			var n:Number = 1 - amount;
			
			concat([
				amount * randomMargin() + n, amount * randomMargin()    , amount * randomMargin()    , 0, amount * 255 * randomMargin(),
				amount * randomMargin()    , amount * randomMargin() + n, amount * randomMargin()    , 0, amount * 255 * randomMargin(),
				amount * randomMargin()    , amount * randomMargin()    , amount * randomMargin() + n, 0, amount * 255 * randomMargin(),
				0, 0, 0, 1, 0
			]);
		}
		
		/**
		* @private
		*/
		private function randomMargin():Number {
			return Math.random() - Math.random();
		}
		
		/**
		* 色調を反転します。
		*/
		public function invert():void {
			concat([
				-1,  0,  0, 0, 255,
				 0, -1,  0, 0, 255,
				 0,  0, -1, 0, 255,
				 0, 0,  0, 1, 0
			]);
		}
		
		/**
		* 本来の色調に戻します。
		*/
		public function identity():void {
			_matrix = [
				1, 0, 0, 0, 0,
				0, 1, 0, 0, 0,
				0, 0, 1, 0, 0,
				0, 0, 0, 1, 0
			];
		}
		
		public function setChannels(r:Number, g:Number, b:Number, a:Number):void {
			var rf:Number =((r & 1) == 1 ? 1:0) + ((r & 2) == 2 ? 1:0) + ((r & 4) == 4 ? 1:0) + ((r & 8) == 8 ? 1:0); 
			if (rf>0) rf=1/rf;
			var gf:Number =((g & 1) == 1 ? 1:0) + ((g & 2) == 2 ? 1:0) + ((g & 4) == 4 ? 1:0) + ((g & 8) == 8 ? 1:0); 
			if (gf>0) gf=1/gf;
			var bf:Number =((b & 1) == 1 ? 1:0) + ((b & 2) == 2 ? 1:0) + ((b & 4) == 4 ? 1:0) + ((b & 8) == 8 ? 1:0); 
			if (bf>0) bf=1/bf;
			var af:Number =((a & 1) == 1 ? 1:0) + ((a & 2) == 2 ? 1:0) + ((a & 4) == 4 ? 1:0) + ((a & 8) == 8 ? 1:0); 
			if (af>0) af=1/af;
			
			concat([
				(r & 1) == 1 ? rf:0,(r & 2) == 2 ? rf:0,(r & 4) == 4 ? rf:0,(r & 8) == 8 ? rf:0, 0,
				(g & 1) == 1 ? gf:0,(g & 2) == 2 ? gf:0,(g & 4) == 4 ? gf:0,(g & 8) == 8 ? gf:0, 0,
				(b & 1) == 1 ? bf:0,(b & 2) == 2 ? bf:0,(b & 4) == 4 ? bf:0,(b & 8) == 8 ? bf:0, 0,
				(a & 1) == 1 ? af:0,(a & 2) == 2 ? af:0,(a & 4) == 4 ? af:0,(a & 8) == 8 ? af:0, 0
			]);
		}

		public function blend(colorMatrix:ColorMatrix, amount:Number):void {
			var n:Number = 1 - amount;
			
			for(var i:Number = 0; i < 20; ++i) {
				_matrix[i] = n * _matrix[i] + amount * colorMatrix.matrix[i];
			}
		}
		
		/**
		* 行列を現在の行列と連結して、2 つの行列の色調効果を効果的に組み合わせます。
		* 
		* @param colorMatrix ColorMatrix オブジェクト、もしくは 5×4 の 20 個の行列からなる Array オブジェクトです。
		*/
		public function concat(colorMatrix:*):void {
			var temp:Array = [];
			var i:uint = 0;
			
			var array:Array;
			if(colorMatrix is ColorMatrix) array = colorMatrix.matrix;
			else if(colorMatrix is Array) {
				if(colorMatrix.length == 20) array = colorMatrix;
				else throwError();
			}
			else throwError();
			
			var matrix:Array = _matrix;
			
			for(var y:int = 0; y < 4; ++y) {
				for(var x:int = 0; x < 5; ++x) {
					temp[i + x] =
						array[i] * matrix[x] +
						array[i + 1] * matrix[x +  5] +
						array[i + 2] * matrix[x + 10] +
						array[i + 3] * matrix[x + 15] +
						((x == 4) ? array[i + 4] : 0);
				}
				i+=5;
			}
			
			_matrix = temp;
		}
		
		/**
		* 新しい ColorMatrix インスタンスとして、この行列のクローンを返します。
		*/
		public function clone():ColorMatrix {
			return new ColorMatrix(_matrix);
		}
		
		/**
		* オブジェクトのストリング表現を返します。
		* 
		* @return オブジェクトのストリング表現です。
		*/
		public function toString():String {
			var temp:String = "ColorMatrix [\n\t";
			var i:uint = 0;
			
			for each(var e:String in matrix) {
				temp += e;
				if(++i % 5 == 0 && i != 20) temp += ",\n\t";
				else if(i < 20) temp += ", ";
				if(i == 20) temp += "\n]";
			}
			
			return temp;
		}
		
		/**
		* @private
		*/
		private function throwError():void {
			throw new ArgumentError("指定できるのは ColorMatrix オブジェクト、もしくは 5×4 の 20 個の行列からなる Array オブジェクトです。");
		}
		
	}
	
}
