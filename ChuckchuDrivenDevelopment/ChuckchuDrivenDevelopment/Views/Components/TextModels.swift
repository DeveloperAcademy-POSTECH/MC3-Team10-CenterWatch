//
//  TextModels.swift
//  ChuckchuDrivenDevelopment
//
//  Created by 박상준 on 2023/09/02.
//

import SwiftUI

public final class AppText {
    
    //Usage: String(localized: "Key")

    //File Name
        //Method Name
    class LocalNotificationManager {
        class MakeNotificationContent {
            let title = LocalizedStringKey("GgoodGgood")
            let body = LocalizedStringKey("Straighten your back🐢")
            let infoKey = LocalizedStringKey("Straighten Fynn")
            let infoValue = LocalizedStringKey("Fynn")
        }
        class SetNextDayNotification {
            let title = LocalizedStringKey("The promised day has passed!")
            let body = LocalizedStringKey("Reset the notification and receive Fynn's message again.🐢")
            let infoKey = LocalizedStringKey("Straighten Fynn")
            let infoValue = LocalizedStringKey("Fynn")
        }
    }
    
    //Usage: String(localized: "Key")
    class NotificationTitle {
        class OpeningVariations {
            let stringArray = [
                LocalizedStringKey("Another lively day today! I'll give you strength! 🐢")
            ]
        }
        class Variations {
            let stringArray = [
                LocalizedStringKey("Knock-knock, it's the spine fairy 🧚"),
                LocalizedStringKey("I'm naturally a turtle neck, but what about you… 🐢"),
                LocalizedStringKey("Save on back surgery costs with just one stretch! 💸"),
                LocalizedStringKey("How about some stretching for your hardworking back? 💪"),
                LocalizedStringKey("Straighten that back! Stretch it out 🌈"),
                LocalizedStringKey("Find my notifications annoying? Wait until your back hurts... 🔥"),
                LocalizedStringKey("A healthy spine leads to a healthy mind! 😌"),
                LocalizedStringKey("Haha! Master, be careful not to hunch like me 🐢"),
                LocalizedStringKey("Keep both your back and spine strong! 🎋"),
                LocalizedStringKey("Stretch it out right from your seat! 🙌"),
                LocalizedStringKey("Give your shoulders a twist~ 💞"),
                LocalizedStringKey("More efficient work with a healthy spine! 💪🦋"),
                LocalizedStringKey("Put some power into your back even during work! 👊"),
                LocalizedStringKey("Good posture, a happy day! 🌟🧘‍♂️"),
                LocalizedStringKey("Check your posture to prevent turtle neck! 🐢👀"),
                LocalizedStringKey("Turtle neck, the fate of developers? No! 👊"),
                LocalizedStringKey("Great ideas come from a healthy spine 💡"),
                LocalizedStringKey("If your posture is hunched, dolphins might mistake you for a friend 🐬"),
                LocalizedStringKey("Oh my, your neck might snap! 💥"),
                LocalizedStringKey("Give your wrists a refreshing twist now and then ⚡️"),
                LocalizedStringKey("Straighten your back firmly 🥢"),
                LocalizedStringKey("Oops! Straighten your spine before it screams in agony 😱"),
                LocalizedStringKey("Fix your posture with a fresh heart 🌷"),
                LocalizedStringKey("My back... save me...! Good posture, stand firm! ⚰️"),
                LocalizedStringKey("Check your posture, ready, set, go! 🏃💨"),
                LocalizedStringKey("Fix your posture once and power up! 🔥"),
                LocalizedStringKey("Oh? You're hunched. Stretch right away! 🐬"),
                LocalizedStringKey("Stretch your arms and legs out! Preventing turtle neck is a must! 🐢💪"),
                LocalizedStringKey("They say 10 seconds of good posture can change 10 years 😘"),
                LocalizedStringKey("Good posture takes responsibility for spinal health! 💪"),
                LocalizedStringKey("Master, what if your posture is worse than mine 😥")
            ]
        }
        class ClosingVariations {
            let stringArray = [
                LocalizedStringKey("Well done! Let's meet with energy again tomorrow! 👋🏻")
            ]
        }
    }
    
    //Usage: String(localized: "Key")
    class OnBoardingView1 {
        class OnboardingText {
            let title = LocalizedStringKey("Creating Good Posture with Pin")
            let subTitle = LocalizedStringKey("At your preferred intervals, receive notifications and easily achieve proper posture instantly.")
        }
        class NextButton {
            let label = LocalizedStringKey("Getting started")
        }
    }

    //Usage: String(localized: "Key")
    class OnBoardingView2 {
        class IconAndText {
            let textLabel = LocalizedStringKey("If you allow notifications, you can receive heartfelt messages from Fynn.")
        }
        class SettingButton {
            let label = LocalizedStringKey("Notification Settings")
        }
    }
    
    //Usage: String(localized: "Key")
    class DailyNotiToggleRow {
        class ToggleButton {
            let label = LocalizedStringKey("Turn off notifications for a day")
        }
    }
    
    //Usage: String(localized: "Key")
    class MainView {
        class PleaseTurnOnTheNotiView {
            let message = LocalizedStringKey("Oh...! Fynn wants to send a message. Activation requires notification settings.")
            let systemSeting = LocalizedStringKey("System Settings")
        }
    }
    
    //Usage: String(localized: "Key")
    class SettingInformationCell {
        class SettingModalButton {
            let name = LocalizedStringKey("Notification Settings")
        }
        class SelectedFrequncyViewer {
            let title = LocalizedStringKey("Notification Interval")
            let unit = LocalizedStringKey("Hour")
        }
        class SelectedHourViewer {
            let startTitle = LocalizedStringKey("Start Time")
            let endTitle = LocalizedStringKey("End Time")
        }
        class SelectedDayViewer {
            let title = LocalizedStringKey("Day")
            let mon = LocalizedStringKey("Mon")
            let tue = LocalizedStringKey("Tue")
            let wed = LocalizedStringKey("Wed")
            let thu = LocalizedStringKey("Thu")
            let fri = LocalizedStringKey("Fri")
        }
    }
    
    //Usage: String(localized: "Key")
    class IfDailyNotiOffCell {
        class View {
            let message = LocalizedStringKey("The notifications are currently turned off. Fynn will be back tomorrow.")
        }
    }
    
    //Usage: String(localized: "Key")
    class ModalView {
        class FrequencySettingRow {
            let label = LocalizedStringKey("Notification Settings")
        }
        class SelectedDayRow {
            let label = LocalizedStringKey("Day")
        }
        class NaviationTitle {
            let label = LocalizedStringKey("Notification Settings")
            let cancel = LocalizedStringKey("Cancel")
            let complete = LocalizedStringKey("Confirm")
        }
    }
    
    //Usage: String(localized: "Key")
    class FrequencySettingRow {
        class Picker {
            let unit = LocalizedStringKey("Hour")
        }
    }
    
    //Usage: String(localized: "Key")
    class TimePickerRow {
        class View {
            let startLabel = LocalizedStringKey("Start Time")
            let endLabel = LocalizedStringKey("End Time")
        }
    }
    
    //Usage: String(localized: "Key")
    class DataModels {
        class SelectedDays {
            let sun = LocalizedStringKey("Sun")
            let mon = LocalizedStringKey("Mon")
            let tue = LocalizedStringKey("Thu")
            let wed = LocalizedStringKey("Wed")
            let thu = LocalizedStringKey("Thu")
            let fri = LocalizedStringKey("Fri")
            let sat = LocalizedStringKey("Sat")
        }
    }
    
    //Usage: String(localized: "Key")
    class CharacterAnimation {
        class EasterEgg {
            let team = LocalizedStringKey("Watching for a watch in the center of the world")
            let guardy = LocalizedStringKey("Guardy / SuHo Kim")
            let theoPark = LocalizedStringKey("Theo(Park) / SangJun Park")
            let lianne = LocalizedStringKey("Lianne / YeEun Choi")
            let alex = LocalizedStringKey("Alex / DoHu Lee")
            let theoNa = LocalizedStringKey("Theo(Na) / GyeongBin Na")
        }
    }
    
}
