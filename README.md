# Dropbox Mailbox

Gestures.

`Time spent: 12 hours`

## Requirements

- On dragging the message left...
  - [x] Initially, the revealed background color should be gray.
  - [x] As the reschedule icon is revealed, it should start semi-transparent and become fully opaque. If released at this point, the message should return to its initial position.
  - [x] After 60 pts, the later icon should start moving with the translation and the background should change to yellow.
    - [x] Upon release, the message should continue to reveal the yellow background. When the animation it complete, it should show the reschedule options.
  - [x] After 260 pts, the icon should change to the list icon and the background color should change to brown.
    - [ ] Upon release, the message should continue to reveal the brown background. When the animation it complete, it should show the list options.
- [x] User can tap to dismissing the reschedule or list options. After the reschedule or list options are dismissed, you should see the message finish the hide animation.
- On dragging the message right...
  - [x] Initially, the revealed background color should be gray.
  - [x] As the archive icon is revealed, it should start semi-transparent and become fully opaque. If released at this point, the message should return to its initial position.
  - [x] After 60 pts, the archive icon should start moving with the translation and the background should change to green.
    - [x] Upon release, the message should continue to reveal the green background. When the animation it complete, it should hide the message.
  - [x] After 260 pts, the icon should change to the delete icon and the background color should change to red.
    - [x] Upon release, the message should continue to reveal the red background. When the animation it complete, it should hide the message.
  - [x] Optional: Panning from the edge should reveal the menu
    - [x] Optional: If the menu is being revealed when the user lifts their finger, it should continue revealing.
    - [x] Optional: If the menu is being hidden when the user lifts their finger, it should continue hiding.
- [ ] Optional: Tapping on compose should animate to reveal the compose view.
- [ ] Optional: Tapping the segmented control in the title should swipe views in from the left or right.
- [x] Optional: Shake to undo.

## Extra stuff

- [x] Search and tool tip thing scroll out of view on view load.
- [x] Gestures don't conflict with each other.
- [x] Shake to undo alert includes the action you just did in the title.
- [x] Pan to close nav once it's open.

![Demo](demo.gif)

Demo in [mp4 format](demo.mp4) instead.
