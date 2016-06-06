//
//  SportCataView.m
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/23.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "SportCataView.h"

@interface SportCataView()

@end

@implementation SportCataView

-(void)setObjs:(NSArray *)objs
{
    _objs = objs;
    for (int i=0; i<_objs.count; i++) {
        if (i==0) {
            self.sportModel = objs[0];
            self.taijiLab.text = self.sportModel.Name;
            self.taijiHotLab.text = self.sportModel.Energy;
        }else if(i==1){
            self.sportModel = objs[1];
            self.gcwLab.text = self.sportModel.Name;
            self.gcwHotLab.text = self.sportModel.Energy;
        }else if (i==2){
            self.sportModel = objs[2];
            self.kzLab.text = self.sportModel.Name;
            self.kzHotLab.text = self.sportModel.Energy;
        }else if (i==3){
            self.sportModel = objs[3];
            self.kbLab.text = self.sportModel.Name;
            self.kbHotLab.text = self.sportModel.Energy;
        }else if (i==4){
            self.sportModel = objs[4];
            self.mzLab.text = self.sportModel.Name;
            self.mzHotLab.text = self.sportModel.Energy;
        }else if (i==5){
            self.sportModel = objs[5];
            self.mbLab.text = self.sportModel.Name;
            self.mbHotLab.text = self.sportModel.Energy;
        }else if (i==6){
            self.sportModel = objs[6];
            self.pbLab.text = self.sportModel.Name;
            self.pbHotLab.text = self.sportModel.Energy;
        }else if (i==7){
            self.sportModel = objs[7];
            self.ptbLab.text = self.sportModel.Name;
            self.ptbHotLab.text = self.sportModel.Energy;
        }else if (i==8){
            self.sportModel = objs[8];
            self.mlqLab.text = self.sportModel.Name;
            self.mlqHotLab.text = self.sportModel.Energy;
        }else if (i==9){
            self.sportModel = objs[9];
            self.swingLab.text = self.sportModel.Name;
            self.swHotLab.text = self.sportModel.Energy;
        }else if (i==10){
            self.sportModel = objs[10];
            self.runLab.text = self.sportModel.Name;
            self.runHotLab.text = self.sportModel.Energy;
        }else if (i==11){
            self.sportModel = objs[11];
            self.tsLab.text = self.sportModel.Name;
            self.tsHotLab.text = self.sportModel.Energy;
        }

    }
}

+(id)sportCataView
{
    NSArray * objs = [[NSBundle mainBundle]loadNibNamed:@"SportCataView" owner:nil options:nil];
    return [objs lastObject];
}



@end
