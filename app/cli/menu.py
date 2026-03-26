from InquirerPy import inquirer


def menu():
    choice = inquirer.select(  # type: ignore
        message="Select an option:",
        choices=["start", "status", "exit"],
    ).execute()

    print(f"You selected: {choice}")
