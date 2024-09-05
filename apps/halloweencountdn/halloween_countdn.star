"""
Applet: Halloween CountDn
Summary: Days until Halloween
Description: Displays the number of days until Halloween.
Author: Anthony Rocchio
"""

load("encoding/base64.star", "base64")
load("math.star", "math")
load("render.star", "render")
load("time.star", "time")

def main(config):
    ghost_gif = base64.decode("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")
    jack_gif = base64.decode("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")

    timezone = config.get("timezone") or "America/New_York"
    now = time.now().in_location(timezone)

    halloween_year = now.year
    if now.month > 10:
        halloween_year = now.year + 1

    halloween = time.time(year = halloween_year, month = 10, day = 31, hour = 0, minute = 0, location = timezone)
    days_til_halloween = math.ceil(time.parse_duration(halloween - now).seconds / 86400)

    return render.Root(
        delay = 500,
        child = render.Row(
            main_align = "center",
            cross_align = "center",
            expanded = True,
            children = [
                render.Image(
                    src = ghost_gif,
                    width = 20,
                    height = 35,
                ),
                render.WrappedText(
                    content = "%s\ndays" % days_til_halloween,
                    font = "6x13",
                    color = "#ff751a",
                    align = "center",
                ),
                render.Image(
                    src = jack_gif,
                    width = 20,
                    height = 35,
                ),
            ],
        ),
    )
