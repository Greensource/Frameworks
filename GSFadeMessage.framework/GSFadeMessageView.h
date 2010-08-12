//	GSFadeMessageView.h
//	Copyright (C) 2010  Pierre DUCHENE
//
//	This program is free software: you can redistribute it and/or modify
//	it under the terms of the GNU General Public License as published by
//	the Free Software Foundation, either version 3 of the License, or
//	(at your option) any later version.
//
//	This program is distributed in the hope that it will be useful,
//	but WITHOUT ANY WARRANTY; without even the implied warranty of
//	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//	GNU General Public License for more details.
//
//	You should have received a copy of the GNU General Public License
//	along with this program.  If not, see <http://www.gnu.org/licenses/>.

#import <UIKit/UIKit.h>

/*!
 *	@class		GSFadeMessageView
 *	@brief		The GSFadeMessageView class provide a nice way to display a simple message to the User.
 *				The aim is only inform briefly the User, you have very low space to write the message so it must be short.
 *				You can add a Title to your message thank to the title property.
 *				The displayed message can be remove by call the dismiss method, this make the message desapear with fade effect.
 *				You can choose the fade duration with the fadeDuration property.
 *				An easy way to use this class is to create the message with the fadeMessageWithTitle:message:duration,
 *				this will automatiquely fade the message and dealloc it with the autorelease pool.
 *	@author		Pierre DUCHENE
 */
@interface GSFadeMessageView : UIView {
	
	UILabel		*_title;
	UILabel		*_message;
	NSInteger	_fadeDuration;
	
}

@property (assign) NSInteger fadeDuration;

/*!
 *	@brief		Create, return and set a message wich fade automatiquely.
 *				You can set Title, message and fade duration.
 *	@param		title  The message title
 *	@param		message	The message
 *	@param		duration The fade duration
 *	@return		A new instance autoreleased of GSFadeMessage
 */
+(id)fadeMessageWithTitle:(NSString*)title message:(NSString*)message duration:(NSInteger)duration;

/*!
 *	@brief		Show the message to the user
 *				The message is displayed directly in the window.
 */
- (void)show;

/*!
 *	@brief		Set the message's title.
 *	@param		title  The message's title.
 */
- (void)setTitle:(NSString*)title;

/*!
 *	@brief		Set the message
 *	@param		message  The message wich will be displayed.
 */
- (void)setMessage:(NSString*)message;

/*!
 *	@brief		Dissmis the message from the screen.
 */
- (void)dismiss;

@end

// TODOLIST
//
// - Improve font size management, prevent programmer for exemple
