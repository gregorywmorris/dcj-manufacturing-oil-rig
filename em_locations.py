
locations = [
            'east-java','papua-new-guinea','guyana','hadrian-south','permian-basin','bakken-formation','woodford-shale', 'caney-shale','cali-off-shore','cali-kearl',
            'canada', 'argentina','germany','netherlands','norway','united-kingdom','angola','chad','equitor-guinea','nigeria','liberia','ivory-coast',
            'azerbaijan','indonesia','kazakhstan','malaysia','quatar','yemmen','thailand','uae','australia'
            ]

list_of_locations = []

def location_generator(locations):
    for location in locations:
        list_of_locations.append(location)

location_generator(locations)