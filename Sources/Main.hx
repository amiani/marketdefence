package;

import kha.Assets;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import haxe.ui.Toolkit;

class Main {
	static inline var width = 768;
	static inline var height = 1024;

	public static function main() {
		System.start({title: "Market Defence", width: width, height: height}, function (_) {
			// Just loading everything is ok for small projects
			Assets.loadEverything(function () {
				Toolkit.init();
				var game = new Game(width, height);
				// Avoid passing update/render directly,
				// so replacing them via code injection works
				Scheduler.addTimeTask(function () { game.update(); }, 0, 1 / 60);
				System.notifyOnFrames(function (frames) { game.draw(frames); });
			});
		});
	}
}
