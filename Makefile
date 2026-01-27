PROJECT_NAME=rpenya-stories-challenge

generate:
	xcodegen generate
	open $(PROJECT_NAME).xcodeproj

open:
	open $(PROJECT_NAME).xcodeproj

clean:
	rm -rf ~/Library/Developer/Xcode/DerivedData/*
