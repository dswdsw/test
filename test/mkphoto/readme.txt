/* 
  readme.strings
  MyImagePicker

  Created by stephen on 15/2/6.

*/

===========================================================================
Using the Sample


MultiplePickerImageController *controller=[MultiplePickerImageController initPicker];
controller.multipleDelegate=self;
[controller show:self];


实现代理 MultiplePickerDeleagte

-(void)didSelectImages:(NSArray *)images
{

}