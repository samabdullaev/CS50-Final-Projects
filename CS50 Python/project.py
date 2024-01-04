import wikipedia
import pyttsx3
import speech_recognition as sr


def main():
    while True:
        print("Choose a scenario:")
        print("1. Text Input")
        print("2. Voice Dictation")
        print("3. Voice Command")
        print("4. Exit")

        choice = input("Enter the number of your choice: ")

        if choice == '1':
            print("Scenario 1:")
            user_input_1 = get_user_input()
            process_and_speak(user_input_1)

        elif choice == '2':
            print("\nScenario 2:")
            problem_2 = voice_recognition()
            print("You said:", problem_2)
            process_and_speak(problem_2)

        elif choice == '3':
            print("\nScenario 3:")
            problem_3 = activate_assistant()

            if problem_3:
                print("You said:", problem_3)
                process_and_speak(problem_3)
            else:
                print("No valid voice command detected.")

        elif choice == '4':
            print("Exiting the program. Goodbye!")
            break

        else:
            print("Invalid choice. Please enter a number between 1 and 4.")


def process_and_speak(user_input):
    text_to_speech(user_input)
    answer = wikipedia.summary(user_input)[:150]
    print("Wikipedia Answer: " + answer)
    text_to_speech(answer)


def get_user_input():
    user_input = input("User: ")
    return user_input


def voice_recognition():
    recognizer = sr.Recognizer()
    with sr.Microphone() as source:
        print("Speak:")
        audio = recognizer.listen(source)
        print("Processing...")
        try:
            problem = recognizer.recognize_google(audio)
            return problem
        except sr.UnknownValueError:
            return "Sorry, I couldn't understand the audio."
        except sr.RequestError as e:
            return f"Could not request results from Google Speech Recognition service; {e}"


def text_to_speech(text):
    engine = pyttsx3.init()
    engine.say(text)
    engine.runAndWait()


def activate_assistant():
    print("Say 'Sam <your problem>' to activate the assistant.")
    user_input = voice_recognition()
    voice_trigger = "Sam"

    if voice_trigger.lower() in user_input.lower():
        return user_input[len(voice_trigger):].strip()
    else:
        return None


if __name__ == "__main__":
    main()
