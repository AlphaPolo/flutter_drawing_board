import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../flutter_drawing_board.dart';
import '../../paint_extension.dart';

/// 绘制对象
abstract class PaintContent {
  PaintContent();

  PaintContent.paint(this.paint);

  /// 画笔
  late Paint paint;
  bool? isPrimary;

  /// 复制实例，避免对象传递
  PaintContent copy();

  /// 绘制核心方法
  /// * [deeper] 当前是否为底层绘制
  /// * 出于性能考虑
  /// * 绘制过程为表层绘制，绘制完成抬起手指时会进行底层绘制
  void draw(Canvas canvas, Size size, bool deeper);

  /// 正在绘制
  void drawing(Offset nowPoint);

  /// 开始绘制
  void startDraw(Offset startPoint);

  void setIsPrimary(bool isPrimary, DrawingController controller) {
    this.isPrimary = isPrimary;
    if(!isPrimary) {
      paint = paint.copyWith(color: controller.getSecondaryColor);
    }
  }

  /// toJson
  Map<String, dynamic> toContentJson();

  /// toJson
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'type': runtimeType.toString(),
      ...toContentJson(),
    };
  }
}
