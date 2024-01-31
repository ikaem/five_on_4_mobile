generate: 
	dart run build_runner build --delete-conflicting-outputs

serve_fake: 
	cd fake_server; npx json-server --watch db.json