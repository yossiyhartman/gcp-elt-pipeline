import datetime
import random

Record = tuple[str, str, str]


class Generator:
    def __init__(self) -> None:
        self.people = ["a", "b", "c", "d"]
        self.mood = ["happy", "optimistic", "hungry", "horny", "motivated"]

    def generate(self, days: int = 10) -> dict[str, list[str]]:
        """Generate some data for x amount of days."""

        data = {
            "people_id": [],
            "date": [],
            "mood": [],
        }

        for p in self.people:
            for i in range(days):
                event_time = (datetime.datetime.now() - datetime.timedelta(days=i)).strftime("%d-%m-%Y")
                todays_mood = random.choice(self.mood)

                data["people_id"].append(p)
                data["date"].append(event_time)
                data["mood"].append(todays_mood)

        return data
