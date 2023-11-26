from PIL import Image
import os

def convert_image():
    # Ask for the file location
    file_location = input("Enter the file location of the image: ")

    # List all image files in the directory
    image_files = [f for f in os.listdir(file_location) if f.endswith(('.png', '.jpg', '.jpeg', '.tiff', '.bmp', '.gif'))]
    print("Image files in directory:")
    for i, f in enumerate(image_files):
        print(f"{i}. {f}")

    # Ask user to select an image file
    image_index = int(input("Enter the number of the image file to convert: "))
    image_file = image_files[image_index]

    # Ask for the format to convert to
    format_to = input("Enter the image format to convert to (png, jpg, etc.): ")

    # Open and convert the image
    img = Image.open(os.path.join(file_location, image_file))
    img = img.convert('RGB')

    # Ask to save in the same location
    same_location = input("Save in the same location? (yes/no): ")
    if same_location.lower() == 'yes':
        destination = file_location
    else:
        destination = input("Enter the new file location: ")

    # Save the image
    filename, _ = os.path.splitext(image_file)
    img.save(os.path.join(destination, f"{filename}.{format_to}"), format_to)
    print(f"Image saved at {os.path.join(destination, f'{filename}.{format_to}')}")
