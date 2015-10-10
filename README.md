# Pre-work - *tipCalculator*

**tipCalculator** is a tip calculator application for iOS.

Submitted by: **Chris Guzman**

Time spent: **11.5** hours spent in total

## User Stories

The following **required** functionality is complete:

* [X] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [X] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [X] UI animations
* [X] Remembering the bill amount across app restarts (if <10mins)
* [X] Using locale-specific currency and currency thousands separators.
* [X] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

* [X] Allow user to select different rates of tipping based on type of service they received.
* [X] Remember the selected segmented control option across app restarts.
* [X] Add images.
* [X] Restrict the input in the bill text field to values that are valid currency using a delegate.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/pZCo7T1Gk6.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [Recordit](http://recordit.co/).

## Notes

I had to learn how to use a table view to make the app look the way I wanted it to.

I also had to deal with the fact that Obj C does not support switching on strings in case statements.

I learned how to add images to iOS apps.

It was fun and challenging to learn how to use locale-specific currency and currency thousands separators. The most rewarding challenge to solve was converting commas as thousand seperators to decimals to do math.

I learned how to use delegates so that I could restrict the input in the text field to values that are valid currency: such as only allowing one currency thousands separators and only allowing two decimal places after a digit.

## License

    Copyright [2015] [Chris Guzman]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
