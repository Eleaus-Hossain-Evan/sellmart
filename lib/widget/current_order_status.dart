import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';

class CurrentOrderStatus extends StatelessWidget {

  final int state;

  CurrentOrderStatus(this.state);

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        Stack(
          alignment: Alignment.center,
          children: [

            Container(
              height: .375 * SizeConfig.heightSizeMultiplier,
              color: Colors.black54,
              margin: EdgeInsets.only(
                left: 3.84 * SizeConfig.widthSizeMultiplier,
                right: 3.84 * SizeConfig.widthSizeMultiplier,
              ),
            ),

            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        height: 4.75 * SizeConfig.heightSizeMultiplier,
                        width: 9.74 * SizeConfig.widthSizeMultiplier,
                        padding: EdgeInsets.all(.6 * SizeConfig.heightSizeMultiplier),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: _completeState(),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 2.56 * SizeConfig.widthSizeMultiplier,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Container(
                          height: 4.75 * SizeConfig.heightSizeMultiplier,
                          width: 9.74 * SizeConfig.widthSizeMultiplier,
                          padding: EdgeInsets.all(.6 * SizeConfig.heightSizeMultiplier),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: (state + 1) == 1 ? Colors.green : Colors.black38, width: state >= 1 ? 0 : .256 * SizeConfig.widthSizeMultiplier),
                            ),
                            child: state >= 1 ? _completeState() : ((state + 1) == 1 ? _nextState() : Container()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 1.28 * SizeConfig.widthSizeMultiplier,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Container(
                          height: 4.75 * SizeConfig.heightSizeMultiplier,
                          width: 9.74 * SizeConfig.widthSizeMultiplier,
                          padding: EdgeInsets.all(.6 * SizeConfig.heightSizeMultiplier),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: (state + 1) == 2 ? Colors.green : Colors.black38, width: state >= 2 ? 0 : .256 * SizeConfig.widthSizeMultiplier),
                            ),
                            child: state >= 2 ? _completeState() : ((state + 1) == 2 ? _nextState() : Container()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 1.28 * SizeConfig.widthSizeMultiplier,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Container(
                          height: 4.75 * SizeConfig.heightSizeMultiplier,
                          width: 9.74 * SizeConfig.widthSizeMultiplier,
                          padding: EdgeInsets.all(.6 * SizeConfig.heightSizeMultiplier),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: (state + 1) == 3 ? Colors.green : Colors.black38, width: state >= 3 ? 0 : .256 * SizeConfig.widthSizeMultiplier),
                            ),
                            child: state >= 3 ? _completeState() : ((state + 1) == 3 ? _nextState() : Container()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 2.56 * SizeConfig.widthSizeMultiplier,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Container(
                          height: 4.75 * SizeConfig.heightSizeMultiplier,
                          width: 9.74 * SizeConfig.widthSizeMultiplier,
                          padding: EdgeInsets.all(.6 * SizeConfig.heightSizeMultiplier),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: (state + 1) == 4 ? Colors.green : Colors.black38, width: state >= 4 ? 0 : .256 * SizeConfig.widthSizeMultiplier),
                            ),
                            child: state >= 4 ? _completeState() : ((state + 1) == 4 ? _nextState() : Container()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      Container(
                        height: 4.75 * SizeConfig.heightSizeMultiplier,
                        width: 9.74 * SizeConfig.widthSizeMultiplier,
                        padding: EdgeInsets.all(.6 * SizeConfig.heightSizeMultiplier),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: (state + 1) == 5 ? Colors.green : Colors.black38, width: state >= 5 ? 0 : .256 * SizeConfig.widthSizeMultiplier),
                          ),
                          child: state >= 5 ? _completeState() : ((state + 1) == 5 ? _nextState() : Container()),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: 1 * SizeConfig.heightSizeMultiplier,),

        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(Constants.ORDER_STATES[0],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 1.5 * SizeConfig.textSizeMultiplier,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(
                  right: 2.56 * SizeConfig.widthSizeMultiplier,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Text(Constants.ORDER_STATES[1],
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontSize: 1.5 * SizeConfig.textSizeMultiplier,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(
                  right: 1.28 * SizeConfig.widthSizeMultiplier,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [


                    Text(Constants.ORDER_STATES[2],
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontSize: 1.5 * SizeConfig.textSizeMultiplier,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 1.28 * SizeConfig.widthSizeMultiplier,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Text(Constants.ORDER_STATES[3],
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontSize: 1.5 * SizeConfig.textSizeMultiplier,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 2.56 * SizeConfig.widthSizeMultiplier,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Text(Constants.ORDER_STATES[4],
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontSize: 1.5 * SizeConfig.textSizeMultiplier,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  Text(Constants.ORDER_STATES[5],
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 1.5 * SizeConfig.textSizeMultiplier,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }


  Widget _completeState() {

    return CircleAvatar(
      backgroundColor: Colors.green,
      child: Icon(Icons.check, color: Colors.white, size: 5.5 * SizeConfig.imageSizeMultiplier,),
    );
  }

  Widget _nextState() {

    return Padding(
      padding: EdgeInsets.all(1 * SizeConfig.heightSizeMultiplier),
      child: CircleAvatar(
        backgroundColor: Colors.green,
      ),
    );
  }
}