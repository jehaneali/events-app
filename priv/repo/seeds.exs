# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     EventsApp.Repo.insert!(%EventsApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias EventsApp.Repo
alias EventsApp.Usrs.Usr
alias EventsApp.Events.Event

sara = Repo.insert!(%Usr{name: "Sara", email: "sara@gmail.com"})
jada = Repo.insert!(%Usr{name: "Jada", email: "jada@gmail.com"})

Repo.insert!(%Event{usr_id: sara.id, name: "Picnic", when: ~D[2021-06-15], description: "Sara is having a picnic!"})
Repo.insert!(%Event{usr_id: jada.id, name: "Paint Night", when: ~D[2022-02-24], description: "Jada's hosting a paint night!"})
