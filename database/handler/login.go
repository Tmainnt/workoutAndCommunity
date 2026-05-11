package handler

import (
	"database/sql"
	"encoding/json"
	"log"
	"net/http"
	"time"
	auth "woc/database/auth"

	"golang.org/x/crypto/bcrypt"
)

type loginRequest struct {
	Req_Email    string `json:"user_email"`
	Req_Password string `json:"user_pass"`
}

type User struct {
	Name            string    `json:"user_name"`
	Password        string    `json:"-"`
	Email           string    `json:"user_email"`
	FName           string    `json:"first_name"`
	LName           string    `json:"last_name"`
	Gender          string    `json:"gender"`
	DOF             time.Time `json:"date_of_birth"`
	PhoneNB         string    `json:"phone_number"`
	Role            string    `json:"role"`
	ProfileImage    string    `json:"profile_image"`
	Status          string    `json:"status"`
	CreateTimestamp time.Time `json:"create_timestamp"`
	UpdateTimestamp time.Time `json:"update_timestamp"`
}

func LoginHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var req loginRequest
		var user User
		err := json.NewDecoder(r.Body).Decode(&req)
		if err != nil {
			http.Error(w, "Invalid json", 400)
			log.Println(err)
			return
		}

		if req.Req_Email == "" || req.Req_Password == "" {
			http.Error(w, "Email and password required", 400)
			log.Println(err)
			return
		}

		err = db.QueryRow(
			`SELECT user_name, user_email, gender, date_of_birth, phone_number, user_pass, role, profile_image, status, create_timestamp, update_timestamp 
	 FROM users WHERE user_email=$1`,
			req.Req_Email,
		).Scan(
			&user.Name,
			&user.Email,
			&user.Gender,
			&user.DOF,
			&user.PhoneNB,
			&user.Password,
			&user.Role,
			&user.ProfileImage,
		)

		if err != nil {
			if err == sql.ErrNoRows {
				http.Error(w, "User not found	", 400)
				log.Println(err)
				return
			}
			http.Error(w, "Database Error", 500)
			log.Println(err)
			return
		}

		err = bcrypt.CompareHashAndPassword(
			[]byte(user.Password),
			[]byte(req.Req_Password))

		if err != nil {
			http.Error(w, "Wrong Password", 401)
			log.Println(err)
			return
		}

		token, err := auth.GenerateToken(user.Email, user.Role)
		_, err = db.Exec("UPDATE users SET status=$1", "Active")
		if err != nil {
			http.Error(w, "Can't update database.", 500)
		}

		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(map[string]interface{}{
			"message": "success",
			"token":   token,
			"user":    user,
		})
	}
}
