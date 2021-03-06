// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:async';

Map technoUrl = {
  "Polymer": ["https://www.polymer-project.org/1.0/", "polymer"],
  "Dart": ["https://www.dartlang.org/", "dart"],
  "Mysql": ["https://www.mysql.com/", "mysql"],
  "Canvas": ["http://www.w3schools.com/html/html5_canvas.asp", "blank"],
  "Javascript": ["https://www.javascript.com", "javascript"],
  "Angular2": ["https://angular.io/docs/dart/latest/index.html", "angular2"],
  "Django": ["https://www.djangoproject.com/start/overview/", "django"],
  "Html": ["http://www.w3schools.com/html/default.asp", "blank"],
  "WebGL": ["https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API/Tutorial/Getting_started_with_WebGL", "blank"],
  "Scrypt": ["https://en.wikipedia.org/wiki/Scrypt", "blank"],
  "AES": ["https://en.wikipedia.org/wiki/Advanced_Encryption_Standard", "blank"],
  "TOTP": ["https://en.wikipedia.org/wiki/Time-based_One-time_Password_Algorithm", "blank"],
};

Map projectsUrls = {
  'canvas': ["perso/canvas%20experimenting/web", "Canvas Experiment"],
  'note_poly': ["perso/perso/build/web", "TODO Lists"],
  'blood_raven': ["perso/blood_raven_client/", "Blood Raven"],
  'portfolio': ["perso/portfolio", 'Portfolio'],
  'webgl_test': ["perso/chess_webgl", "WebGL Test"],
  'lastfmStats': ["perso/lastfmStats", "LastFm Stats"],
  'twoAuthWeb': ["perso/twoAuthWeb", "2FA keys"],
};

List<Element> showcases = [
];

void main() {
  for (String name in projectsUrls.keys){
    showcases.add(querySelector("#$name"));
  }
  showcases.forEach((Element el){
    el.parent.onClick.listen((_){
      window.open(projectsUrls[el.id][0], projectsUrls[el.id][1]);
    });
    el.parent.onMouseOver.listen((_){
      if (el.parent.classes.contains('contentWIPShowcaseContainer')){
        querySelector('#wipContainer').classes.add('animateColorFocusHoverClass');
        querySelector('#finished').classes.add('animateColorNonFocusHoverClass');
        querySelector('#finishedContainer').classes.add('animateColorNonFocusHoverClass');
      } else {
        querySelector('#finishedContainer').classes.add('animateColorFocusHoverClass');
        querySelector('#wip').classes.add('animateColorNonFocusHoverClass');
        querySelector('#wipContainer').classes.add('animateColorNonFocusHoverClass');
      }
    });
    el.parent.onMouseOut.listen((_){
      if (el.parent.classes.contains('contentWIPShowcaseContainer')){
        querySelector('#wipContainer').classes.remove('animateColorFocusHoverClass');
        querySelector('#finished').classes.remove('animateColorNonFocusHoverClass');
        querySelector('#finishedContainer').classes.remove('animateColorNonFocusHoverClass');
      } else {
        querySelector('#finishedContainer').classes.remove('animateColorFocusHoverClass');
        querySelector('#wip').classes.remove('animateColorNonFocusHoverClass');
        querySelector('#wipContainer').classes.remove('animateColorNonFocusHoverClass');
      }
    });
  });

  querySelectorAll('.showcaseTechno').forEach((Element el){
    String keyTechno = technoUrl[el.innerHtml.substring(1)][1];
    el.classes.add("${keyTechno}Techno");
    el.onClick.listen((_){
      window.open(technoUrl[el.innerHtml.substring(1)][0], el.innerHtml.substring(1));
    });
  });

  querySelectorAll('.colorHoverIndicationContainer').forEach((Element el){
    el.onMouseOver.listen((_){
      el.classes.add('animateColorFocusHoverClass');
    });
    el.onMouseOut.listen((_){
      el.classes.remove('animateColorFocusHoverClass');
    });
  });

  DivElement nameBox = querySelector('#nameBox');
  DivElement authorBox = querySelector('#authorBox');
  String textToDecompose = nameBox.innerHtml;
  String author = authorBox.innerHtml;
  nameBox.innerHtml = "";
  authorBox.innerHtml = "";
  double animationDelay = 0.0;
  double animationAddIteration = 0.25;

  double timerSecondAnimation = 0.0;

  List<String> words = textToDecompose.split(' ');
  words.forEach((String word){
    List<String> letters = word.split('');
    letters.forEach((String letter){
      DivElement l = new DivElement();
      l.classes.add("letterTitle");
      l.innerHtml = letter;
      animationAddIteration *= 0.92;
      animationDelay += animationAddIteration;
      l.style.animation = "letterAppearTitle 1s ease-in-out ${animationDelay}s forwards";
      nameBox.children.add(l);
      timerSecondAnimation = animationDelay + 1.0;
    });
    DivElement space = new DivElement();
    space.classes.add("letterTitle");
    space.innerHtml = "%20";
    space.style.fontSize = "7px";
    nameBox.children.add(space);
  });

  new Timer(new Duration(seconds: timerSecondAnimation.ceil()), (){
    querySelector('#downBox').style.zIndex = "0";
    querySelector('#upperBox').style.zIndex = "2";
    querySelectorAll('.letterTitle').forEach((Element el){
      el.style.zIndex = "10";
    });

    animationDelay = 0.0;
    animationAddIteration = 0.25;

    words = author.split(' ');
    words.forEach((String word){
      List<String> letters = word.split('');
      letters.forEach((String letter){
        DivElement l = new DivElement();
        l.classes.add("letterAuthor");
        l.innerHtml = letter;
        animationAddIteration *= 0.92;
        animationDelay += animationAddIteration;
        l.style.animation = "letterAppearAuthor 1s ease-in-out ${animationDelay}s forwards";
        authorBox.children.add(l);
      });
      DivElement space = new DivElement();
      space.classes.add("letterAuthor");
      space.innerHtml = "%20";
      space.style.fontSize = "4px";
      authorBox.children.add(space);
    });
  });

}

