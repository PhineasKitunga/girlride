
# GirlRide — Firebase (Firestore) Database Structure

## Collections and Documents (Firestore)

### /users/{userId}
- `uid` (string) — Firebase Auth UID
- `role` (string) — "rider" or "driver"
- `fullName` (string)
- `displayName` (string)
- `phone` (string)
- `email` (string)
- `photoURL` (string)
- `verified` (boolean)
- `verification` (map)
  - `idDocumentURL` (string)
  - `selfieURL` (string)
  - `verifiedAt` (timestamp)
  - `status` (string) — "pending", "verified", "rejected"
- `gender` (string) — optional
- `rating` (number) — average rating
- `ratingCount` (number)
- `trustedContacts` (array of maps)
  - `{ name, phone, relation, notifyOnStart, notifyOnPanic }`
- `preferences` (map)
  - `preferredPayment` (string)
  - `communication` (map)
    - `sms` (bool)
    - `push` (bool)
- `createdAt` (timestamp)
- `lastActiveAt` (timestamp)

### /drivers/{driverId}  (can also be a sub-collection under users)
- `uid`
- `vehicle` (map)
  - `make` (string)
  - `model` (string)
  - `color` (string)
  - `plate` (string)
- `documents` (map)
  - `licenseURL`
  - `vehicleRegURL`
  - `backgroundCheckURL` (optional)
- `onlineStatus` (boolean)
- `currentRideId` (string | null)
- `availability` (map)
  - `hours` (map)
- `earnings` (map)
  - `total` (number)
  - `weekly` (number)
- `safetyScore` (number)
- `createdAt`, `updatedAt`

### /rides/{rideId}
- `rideId` (string)
- `riderId` (string)
- `driverId` (string)
- `status` (string) — ["requested","matching","accepted","in_progress","completed","cancelled","emergency"]
- `pickup` (map)
  - `lat` (number)
  - `lng` (number)
  - `address` (string)
- `destination` (map)
  - `lat`
  - `lng`
  - `address`
- `route` (array of {lat,lng,timestamp}) — optional short trace
- `fare` (map)
  - `estimated` (number)
  - `actual` (number)
  - `currency` (string)
- `requestedAt` (timestamp)
- `acceptedAt` (timestamp)
- `startedAt` (timestamp)
- `completedAt` (timestamp)
- `eta` (number) — seconds
- `distanceMeters` (number)
- `safetyEvents` (array of maps)
  - `{ type, timestamp, details }` e.g. "off_route", "panic_pressed"
- `audit` (map) — lightweight logs for automated checks

### /ride_events/{rideId}/events (subcollection)
- `eventId`
- `type` (string) — "location_update","status_change","panic","flagged"
- `location` (map)
- `timestamp`
- `payload` (map)

### /locations/{driverId}  (near-real-time snapshot for driver locations)
- `uid`
- `lat`
- `lng`
- `updatedAt`
- `bearing`
- `speed`
- `rideId` (optional) — indicates current ride

> Note: For high-frequency location updates consider using Realtime Database for lower latency / cheaper writes, or use Cloud Firestore with structured throttling and a `locations` collection optimized for short-lived writes.

### /chats/{chatId}
- `chatId`
- `participants` (array of uids)
- `lastMessage` (map)
  - `text`
  - `senderId`
  - `createdAt`
- `createdAt`

### /chats/{chatId}/messages/{messageId}
- `messageId`
- `text` (string)
- `senderId` (string)
- `createdAt` (timestamp)
- `type` (string) — "text","image"
- `readBy` (array of uids)

### /reports/{reportId}
- `reportId`
- `reportedBy` (uid)
- `targetId` (uid or rideId)
- `category` (string)
- `description` (string)
- `attachments` (array of URLs)
- `status` (string) — "open","investigating","resolved","dismissed"
- `createdAt`
- `handledBy` (admin uid)

### /notifications/{notificationId}
- `userId`
- `type`
- `title`
- `body`
- `data` (map)
- `createdAt`
- `read` (boolean)

### /admin/{adminId}  (optional)
- `uid`
- `role`
- `permissions` (array)
- `createdAt`

### Analytics / safety logs (separate project or BigQuery)
- Export aggregated ride logs, incident trends, driver safety metrics into BigQuery for analysis.

---

## Security & Rules (high-level)
- Only allow authenticated users.
- Riders can only read/write their own user doc.
- Drivers can read limited rider info only when assigned a ride.
- `locations` write should be allowed only for authenticated drivers writing to their own doc.
- `rides` writes should be carefully controlled via Cloud Functions that perform matching.
- Enforce validation on document shapes (lat/lng ranges, timestamps).
- Sensitive documents (background checks) stored in protected storage (Cloud Storage) with restricted access.

---

## Cloud Functions (server-side)
- `onRideRequested` → matchmaking logic (calculate nearest verified female drivers, apply availability)
- `onRideAccepted` → notify rider, reserve driver
- `onPanicPressed` → alert emergency contacts, send push notifications, create incident report
- `onOffRouteDetected` → send automated check and escalate if no response
- `onUserVerificationUploaded` → run moderation/face-match (if integrated with 3rd party)
- `onRideCompleted` → calculate final fare and record earnings
- `scheduledSafetyAudit` → flag drivers with low safety score

---

## Suggested Indexes
- `rides` by `status`, `requestedAt`
- `locations` by `updatedAt`
- `drivers` by `onlineStatus`, `location` (if using geohash)
- `users` by `phone`

