![](etc/EA.png)

#### ver 0.6 (beta)

_This is still beta quality code - feel free to test, create issues, etc. The library doesn't use any private APIs - apps using it should be fine for release on the App Store._

<table width="100%">
<tr>
<td width="300">
<a href="#intro">Intro</a><br>
<a href="#layers">Layer Animations</a><br>
<a href="#springs">Spring Layer Animations</a><br>
<a href="#chains">Chain Animations</a><br>
<a href="#stop">Cancel Chain Animations</a><br>
</td>
<td width="300">
<a href="#installation">Installation</a><br>
<a href="#credit">Credit</a><br>
<a href="#license">License</a><br>
<a href="#version">Version History</a>
</td>
</tr>
</table>

<a name="intro"></a>
Intro
========

`UIView.animateWithDuration:animations:` is really easy to use and you're so familiar with its syntax that you often want it to do just a bit more for you automatically. But it doesn't and you need to import *Bloated.framework* by *Beginner Ninja Coder* in order to make a bit more advanced animations than what `animateWithDuration:animations:` allows you to.

**EasyAnimation** extends what UIKit offers in terms of animations and makes your life much easier because you can do much more without learning some perky new syntax.

<a name="layers"></a>
Easy Layer Animations
========

**EasyAnimation** allows you to animate your layers straight from `animateWithDuration:animations:`. No more `CABasicAnimation` code for you. Just adjust the properties of your layers from within the `animations` block and **EasyAnimation** will take care of the rest:
<table width="100%">
<th>CoreAnimation (before)</th>
<tr>
<td valign="top">
<pre lang="Swift">
    let anim = CABasicAnimation(keyPath: "position.x")
    anim.fromValue = 100.0
    anim.toValue = 200.0
    anim.duration = 2.0
    view.layer.addAnimation(anim, forKey: nil)
</pre>
</td>
</tr>
</table>
<table width="100%">
<th>EasyAnimation (after)</th>
<tr>
<td valign="top">
<pre lang="Swift">
    UIView.animateWithDuration(2.0, animations: {
        self.view.layer.position.x = 200.0
    })
</pre>
</td>
</tr>
</table>

![](etc/moveX.gif)

Or if you need to specify delay, animation options and/or animation curve:

<table width="100%">
<th>CoreAnimation (before)</th>
<tr>
<td valign="top">
<pre lang="Swift">
    let anim = CABasicAnimation(keyPath: "position.x")
    anim.fromValue = 100.0
    anim.toValue = 200.0
    anim.duration = 2.0
    anim.fillMode = kCAFillModeBackwards
    anim.beginTime = CACurrentMediaTime() + 2.0
    anim.timingFunction = CAMediaTimingFunction(name: 
        kCAMediaTimingFunctionEaseOut)
    anim.repeatCount = Float.infinity
    anim.autoreverses = true
    view.layer.addAnimation(anim, forKey: nil)
</pre>
</td>
</tr>
</table>
<table width="100%">
<th>EasyAnimation (after)</th>
<tr>
<td valign="top">
<pre lang="Swift">
    UIView.animateWithDuration(2.0, delay: 2.0, 
        options: .Repeat | .Autoreverse | .CurveEaseOut, 
        animations: {
        self.view.layer.position.x += 200.0

        // let's add more animations 
        // to make it more interesting!
        self.view.layer.cornerRadius = 20.0
        self.view.layer.borderWidth = 5.0
    }, completion: nil)
</pre>
</td>
</tr>
</table>

![](etc/corners.gif)

And if you want to execute a piece of code after the animation is completed - good luck setting up your animation delegate and writing the delegate methods. 

With **EasyAnimation** you just put your code as the `completion` parameter value and **EasyAnimation** executes it for you when your animation completes.

<a name="springs"></a>

Spring Layer Animations
========
One thing I really miss when using CoreAnimation and `CABasicAnimation` is that there's no easy way to create spring animations. Luckily a handy library called `RBBAnimation` provides an excellent implementation of spring animations for layers - I translated the code to Swift and included `RBBSpringAnimation` into `EasyAnimation`. 

Here's how the code to create a spring animation for the layer position, transform and corner radius looks like:

<table width="100%">
<th>EasyAnimation</th>
<tr>
<td valign="top">
<pre lang="Swift">
    UIView.animateWithDuration(2.0, delay: 0.0, 
      usingSpringWithDamping: 0.25, 
      initialSpringVelocity: 0.0, 
      options: nil, 
      animations: {
        self.view.layer.position.x += 200.0
        self.view.layer.cornerRadius = 50.0
        self.view.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.0)
    }, completion: nil)
</pre>
</td>
</tr>
</table>

![](etc/spring.gif)

[Sam Davies](https://github.com/sammyd) collaborated on the spring animations code. Thanks a ton - I couldn't have figured this one on my own!

<a name="chains"></a>

Chain Animations
========

`animateWithDuration:animations:` is really handy but chaining one animation after another is a major pain (especially if we are talking about more than 2 animations).

**EasyAnimation** allows you to use a method to just chain two or more animations together.  Call `animateAndChainWithDuration:delay:options:animations:completion:` and then chain to it more animations like this:

<table width="100%">
<th>EasyAnimation</th>
<tr>
<td valign="top">
<pre lang="Swift">
    UIView.animateAndChainWithDuration(1.0, delay: 0.0, 
      options: nil, animations: {
        self.view.center.y += 100
    }, completion: nil).animateWithDuration(1.0, animations: {
        self.view.center.x += 100
    }).animateWithDuration(1.0, animations: {
        self.view.center.y -= 100
    }).animateWithDuration(1.0, animations: {
        self.view.center.x -= 100
    })
</pre>
</td>
</tr>
</table>

![](etc/chain.gif)

*Yes - that works, give it a try in your project :]*

This code will animate the view along a rectangular path - first downwards, then to the right, then up, then to the initial point where the animation started.

What a perfect oportunity to repeat the animation and make the animation run continuosly! Add `options` parameter to the last `animateWithDuration...` in the chain and turn on the `.Repeat` option. 

This will make the whole chain (e.g. the 4 animations) repeat continuosly.

If you want to pause between any two animations in the chain - just use the `delay` parameter and it will all just work.

<a name="stop"></a>

Cancel Chain Animations
========

If you have a repeating (or a normal) chain animation on screen you can cancel it at any time. Just grab hold of the animation object and call `cancelAnimationChain` on it any time you want.

<pre lang="Swift">
let chain = UIView.animateAndChainWithDuration(1.0, delay: 0.0,
    options: nil, animations: {
        self.square.center.y += 100
    }, completion: nil).animateWithDuration(1.0, animations: {
  [... the rest of the animations in the chain]
</pre>

<pre lang="Swift">
chain.cancelAnimationChain()
</pre>

The animation will not stop immediately but once it completes the current step of the chain it will stop and cancel all scheduled animations in this chain.

<a name="installation"></a>

Installation
========

* To install the library via Cocoapods (recommended) add to your project's **Podfile**:

`pod 'EasyAnimation'`

* To install with the source code - clone this repo or download the source code as a zip file. Include all files within the `EasyAnimation` folder into your project.

<a href="credit"></a>

Credit
========

Author: **Marin Todorov**

* [http://www.underplot.com](http://www.underplot.com)
* [https://twitter.com/icanzilb](https://twitter.com/icanzilb)

More about Marin:

<table>
<tr>
<td>
<a href="http://www.ios-animations-by-tutorials.com/"><img src="http://www.underplot.com/images/thumbs/iat.jpg" width="170"><br>
<b>iOS Animations by Tutorials</b>, Author</a>
</td>
<td>
<a href="http://www.ios-animations-by-emails.com/"><img src="http://www.underplot.com/images/thumbs/ios-animations-by-emails.jpg" width="170"><br>
iOS Animations by Emails Newsletter, Author</a>
</td>
</tr>
</table>

Includes parts of [RBBAnimation](https://github.com/robb/RBBAnimation) by [Robert Böhnke](https://github.com/robb). The code is translated from Objective-C to Swift by Marin Todorov.

Collaborator on the spring animation integration: [Sam Davies](https://github.com/sammyd).

<a name="license"></a> 

License
========
`EasyAnimation` is available under the MIT license. See the LICENSE file for more info.

`RBBAnimation` license: [https://github.com/robb/RBBAnimation/blob/master/LICENSE](https://github.com/robb/RBBAnimation/blob/master/LICENSE)

<a name="version"></a>

To Do
=========

* polish spring animation to look exactly like the UIKit one
* add `CALayer.animateWithDuration:animations:`.. for the people who want to use different methods for view and layer animations
* `.Autoreverse` for chain animations (if possible)
* add support for keyframe animation along the path via a custom property
* cool demos...


Version History
========

* 0.6 - first beta version
