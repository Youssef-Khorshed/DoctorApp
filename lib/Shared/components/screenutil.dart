import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void Util(BuildContext context) {
  ScreenUtil.init(BoxConstraints(),
      context: context, minTextAdapt: true, designSize: Size(360, 1880));
}
